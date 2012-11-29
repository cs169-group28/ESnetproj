class Perfsonar
	require 'xmlsimple'

	@@xmlTemplatesFolder = "app/assets/xml-templates/"

	@@bwctlRequestFile = "SetupDataRequest-bwctl-2.xml"
	@@owampRequestFile = "SetupDataRequest-owamp-2.xml"
	@@tracerouteRequestFile = "SetupDataRequest-2.xml"

	@@owampURI = ':8085/perfSONAR_PS/services/pSB'
	@@bwctlURI = ':8085/perfSONAR_PS/services/pSB'
	@@tracerouteURI = ':8086/perfSONAR_PS/services/tracerouteMA'

	#@@nmwgt = 'http://ggf.org/ns/nmwg/topology/2.0/'

	def Perfsonar.requestBwctlData (src, dst)
		startTime = 1.month.ago.to_i
		endTime = Time.now.to_i

		bwctlRequest = Nokogiri::XML(File.open(@@xmlTemplatesFolder + @@bwctlRequestFile))
		bwctlRequest = self.updateParameters(bwctlRequest, src, dst, startTime, endTime)

		domain = 'http://' + dst + @@bwctlURI
		response = Nokogiri::XML(self.postToPerfSonar(domain, bwctlRequest).body)

		responseList = []
		response.at_xpath('//nmwg:data', 'nmwg'=>'http://ggf.org/ns/nmwg/base/2.0/').children.each do |child|
			responseList.append( {timeValue:child['timeValue'], throughput:child['throughput']})
		end

		responseList
	end

	def Perfsonar.requestOwampData (src, dst)
		startTime = 12.hours.ago.to_i
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

	def Perfsonar.requestTracerouteData (src, dst)
		startTime = 1.hours.ago.to_i
		endTime = Time.now.to_i

		tracerouteRequest = Nokogiri::XML(File.open(@@xmlTemplatesFolder + @@tracerouteRequestFile))
		tracerouteRequest = self.updateParameters(tracerouteRequest, src, dst, startTime, endTime)
		
		domain = 'http://' + src + @@tracerouteURI
		response = Nokogiri::XML(self.postToPerfSonar(domain, tracerouteRequest).body)

		responseList = []
		response.xpath('//nmwg:data', 'nmwg'=>'http://ggf.org/ns/nmwg/base/2.0/').each do |data|
			data.children.each do |child|

				responseList.append( {queryNum:child['queryNum'], hop:child['hop'], value:child['value'], numBytes:child['numBytes'], 
				valueUnits:child['valueUnits'], timeValue:child['timeValue'], timeType:child['timeType'] } )
			end
		end

		responseList.sort_by{|e| [e[:timeValue],e[:queryNum],e[:value].to_f]}
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
