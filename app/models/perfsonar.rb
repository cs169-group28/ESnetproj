class Perfsonar
	require 'socket'
	require 'xmlsimple'
	require 'json'

	@@xmlTemplatesFolder = "app/assets/xml-templates/"

	@@bwctlRequestFile = "SetupDataRequest-bwctl-2.xml"
	@@owampRequestFile = "SetupDataRequest-owamp-2.xml"
	@@tracerouteRequestFile = "SetupDataRequest-2.xml"

	@@owampURI = ':8085/perfSONAR_PS/services/pSB'
	@@bwctlURI = ':8085/perfSONAR_PS/services/pSB'
	@@tracerouteURI = ':8086/perfSONAR_PS/services/tracerouteMA'

	#@@nmwgt = 'http://ggf.org/ns/nmwg/topology/2.0/'

	def Perfsonar.requestBwctlData (src, dst, time)
		startTime = time.to_i.hours.ago.to_i
		endTime = Time.now.to_i

		bwctlRequest = Nokogiri::XML(File.open(@@xmlTemplatesFolder + @@bwctlRequestFile))
		bwctlRequest = self.updateParameters(bwctlRequest, src, dst, startTime, endTime)

		domain = 'http://' + dst + @@bwctlURI
		response = Nokogiri::XML(self.postToPerfSonar(domain, bwctlRequest).body)

		responseList = []
		response.at_xpath('//nmwg:data', 'nmwg'=>'http://ggf.org/ns/nmwg/base/2.0/').children.each do |child|
			responseList.append( {timeValue:child['timeValue'], throughput:child['throughput']})
		end

		responseList.sort_by{|e| [e[:timeValue]]}  
	end

	def Perfsonar.requestOwampData (src, dst, time)
		startTime = time.to_i.hours.ago.to_i
		endTime = Time.now.to_i

		owampRequest = Nokogiri::XML(File.open(@@xmlTemplatesFolder + @@owampRequestFile))
		owampRequest = self.updateParameters(owampRequest, src, dst, startTime, endTime)

		domain = 'http://' + dst + @@owampURI
		response = Nokogiri::XML(self.postToPerfSonar(domain, owampRequest).body)

		responseList = []
		response.at_xpath('//nmwg:data', 'nmwg'=>'http://ggf.org/ns/nmwg/base/2.0/').children.each do |child|
			responseList.append( {minTTL:child['minTTL'], min_delay:child['min_delay'], maxError:child['maxError'], max_delay:child['max_delay'], 
				duplicates:child['duplicates'], endTime:child['endTime'], loss:child['loss'], sent:child['sent'], startTime:child['startTime'], maxTTL:child['maxTTL'] } )
		end

		responseList
	end

	def Perfsonar.requestTracerouteData (src, dst, time)
		startTime = time.to_i.hours.ago.to_i
		endTime = Time.now.to_i

		tracerouteRequest = Nokogiri::XML(File.open(@@xmlTemplatesFolder + @@tracerouteRequestFile))
		tracerouteRequest = self.updateParameters(tracerouteRequest, src, dst, startTime, endTime)
		
		domain = 'http://' + src + @@tracerouteURI
		response = Nokogiri::XML(self.postToPerfSonar(domain, tracerouteRequest).body)

		responseList = []
		response.xpath('//nmwg:data', 'nmwg'=>'http://ggf.org/ns/nmwg/base/2.0/').each do |data|
			data.children.each do |child|

				responseList.append( {queryNum:child['queryNum'], hop:child['hop'], value:child['value'], timeValue:child['timeValue']} )
			end
		end

		responseList = responseList.sort_by{|e| [e[:timeValue],e[:queryNum],e[:value].to_f]}
		
		#Grouping initial response list by timeValue. That is each request and data associated with it
		requests = responseList.group_by {|entry| entry[:timeValue]}

		#Grouping each request (timeValue) by server and associated data
		requests.each_key do |key|
			requests[key] = requests[key].group_by {|row| row[:hop]}
		end
		
		#Remaking the server hash by appending only the time data
		requests.each_key do |key|
			request = requests[key]
			request.each_key do |serverKey|
				serverList = request[serverKey]
				averageTime = 0.0
				serverList.each do |queryNum|
					averageTime += queryNum[:value].to_f
				end
				averageTime = averageTime/3
				request[serverKey] = averageTime
			end
		end

		srcIP = IPSocket::getaddress(src)

		#Create pairs of servers for each request

		requests.each_key do |key|
			request = requests[key]
			#List of servers
			servers = request.keys
			pairHash = {}
			pairHash[ [srcIP, servers[0]] ] = request[servers[0]]
			for i in 0..servers.length-2
				begin
					value = request[servers[i+1]] - request[servers[i]]
					serverPair = [servers[i], servers[i+1]]
					pairHash[serverPair] = value
				rescue
				end
			end
			requests[key] = pairHash
		end

		#p "===============STAGE3============"
		#p requests
		

		#Array of all request hashes
		requestValues = requests.values

		#Array of all possible servers pairs, no duplicates
		serverPairList = []
		requests.each_key do |key|
			request = requests[key]
			serverPairList.push(*request.keys)
		end
		#removing duplicates
		serverPairList = serverPairList.uniq

		#creatingUnique server list
		serverList = []
		serverPairList.each do |server|
			serverList.append(server[0])
			serverList.append(server[1])
		end
		serverList = serverList.uniq

		finalHash = {}
		#Averaging, etc.
		requests.each_key do |key|
			request = requests[key]
			request.each_key do |serverPair|
				begin
					finalHash[serverPair][0] += request[serverPair]
					finalHash[serverPair][1] += 1
				rescue
					finalHash[serverPair] = [request[serverPair], 1]
				end
			end
		end

		finalHash.each_key do |key|
			finalHash[key][0] = finalHash[key][0]/finalHash[key][1]
		end

		#p "========SERVERPAIRLIST======"
		#p finalHash

		listOfNodes = []

		serverList.each do |server|
			tempHash = {}
			tempHash["name"] = server
			tempHash["color"] = "#E41A1C"
			listOfNodes.append(tempHash)
		end

		listOfLinks = []

		finalHash.each_key do |key|
			finalHash[key][0] = finalHash[key][0]/finalHash[key][1]
			tempHash = {}
			tempHash["source"] = serverList.index(key[0])
			tempHash["target"] = serverList.index(key[1])
			tempHash["value"] = finalHash[key][1]
			tempHash["colorValue"] = finalHash[key][0]
			listOfLinks.append(tempHash)
		end

		@masterHash = {}
		@masterHash["nodes"] = listOfNodes
		@masterHash["links"] = listOfLinks
		@linksjs=listOfLinks
		@masterHash = @masterHash.to_json

		p "===========MASTER HASH========="
		puts @masterHash

		###########################

		finalMatrix = []
		finalMatrixOfColorValues = []

		serverList.each do |server1|
			rowValues = []
			rowColorValues = []
			serverList.each do |server2|
				key = [server1, server2]
				if finalHash.has_key?(key)
					rowValues.append(finalHash[key][1])
					rowColorValues.append(finalHash[key][0])
				else
					rowValues.append(0)
					rowColorValues.append(0)
				end
			end
			finalMatrix.append(rowValues)
			finalMatrixOfColorValues.append(rowColorValues)
		end

		p "===========MASTER MATRIX======="

		@masterMatrix = finalMatrix.to_json
		puts @masterMatrix
		@masterNodes = listOfNodes.to_json.html_safe

		## RETURN list of all important data structures
            
		[responseList, @masterHash, @masterMatrix, @masterNodes, finalMatrixOfColorValues, @linksjs]


		## RETURN responseList
		#responseList
	end

	private

	def self.updateParameters(template, src, dst, startTime, endTime)
		template.at_xpath('//nmwgt:src', 'nmwgt'=>'http://ggf.org/ns/nmwg/topology/2.0/')['value']=src
		template.at_xpath('//nmwgt:dst', 'nmwgt'=>'http://ggf.org/ns/nmwg/topology/2.0/')['value']=dst
		template.at_xpath('//nmwg:parameter[@name="startTime"]', 'nmwg'=>'http://ggf.org/ns/nmwg/base/2.0/').content=startTime
		template.at_xpath('//nmwg:parameter[@name="endTime"]', 'nmwg'=>'http://ggf.org/ns/nmwg/base/2.0/').content=endTime
		template	
	end

	def self.postToPerfSonar(domain, data)
		url = URI.parse(domain)
		request = Net::HTTP::Post.new(url.path)
		request.body = data.to_xml
		response = Net::HTTP.start(url.host, url.port) {|http| http.request(request)}
	end

end
