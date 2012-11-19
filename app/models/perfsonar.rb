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
		# bwctlRequest = XmlSimple.xml_in(@@xmlTemplatesFolder + @@bwctlRequestFile)

		bwctlRequest = Nokogiri::XML(File.open(@@xmlTemplatesFolder + @@bwctlRequestFile))

		#src = 'sdsc-pt1.es.net'
		#dst = 'fnal-pt1.es.net'

		#ip address update
		bwctlRequest.at_xpath('//nmwgt:src', 'nmwgt'=>'http://ggf.org/ns/nmwg/topology/2.0/')['value']=src
		bwctlRequest.at_xpath('//nmwgt:dst', 'nmwgt'=>'http://ggf.org/ns/nmwg/topology/2.0/')['value']=dst

		# p 'REQUEST =========================================='
		# p bwctlRequest
		# p 'REQUEST END =========================================='

		# p 'REQUEST XML OUT=========================================='
		# p bwctlRequest.to_xml
		# p 'REQUEST END =========================================='

		# p 'RESPONSE =========================================='
		# p self.postToPerfSonar(dst, bwctlRequest)
		# p 'RESPONSE END =========================================='

		domain = 'http://' + dst + @@bwctlURI

		response = Nokogiri::XML(self.postToPerfSonar(domain, bwctlRequest).body)

		responseList = []
		response.at_xpath('//nmwg:data', 'nmwg'=>'http://ggf.org/ns/nmwg/base/2.0/').children.each do |child|
			responseList.append( {timeValue:child['timeValue'], throughput:child['throughput']})
		end

		responseList
	end

	def Perfsonar.requestOwampData (src, dst)
		owampRequest = Nokogiri::XML(File.open(@@xmlTemplatesFolder + @@owampRequestFile))

		#src = '198.124.238.106'
		#dst = '198.129.252.142'

		owampRequest.at_xpath('//nmwgt:src', 'nmwgt'=>'http://ggf.org/ns/nmwg/topology/2.0/')['value']=src
		owampRequest.at_xpath('//nmwgt:dst', 'nmwgt'=>'http://ggf.org/ns/nmwg/topology/2.0/')['value']=dst

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
		tracerouteRequest = Nokogiri::XML(File.open(@@xmlTemplatesFolder + @@tracerouteRequestFile))

		#src = 'lbl-pt1.es.net'
		#dst = 'pppl-pt1.es.net'

		#ip address update
		tracerouteRequest.at_xpath('//nmwgt:src', 'nmwgt'=>'http://ggf.org/ns/nmwg/topology/2.0/')['value']=src
		tracerouteRequest.at_xpath('//nmwgt:dst', 'nmwgt'=>'http://ggf.org/ns/nmwg/topology/2.0/')['value']=dst

		domain = 'http://' + src + @@tracerouteURI

		response = Nokogiri::XML(self.postToPerfSonar(domain, tracerouteRequest).body)

		responseList = []
		response.xpath('//nmwg:data', 'nmwg'=>'http://ggf.org/ns/nmwg/base/2.0/').each do |data|
			data.children.each do |child|

				responseList.append( {queryNum:child['queryNum'], hop:child['hop'], value:child['value'], numBytes:child['numBytes'], 
				valueUnits:child['valueUnits'], timeValue:child['timeValue'], timeType:child['timeType'] } )
			end
		end

		responseList

	end

	private

	def self.postToPerfSonar(domain, data)
		p '========'
		p data.to_xml
		p '========'
		p domain
		#domain = 'lbl-pt1.es.net'
		url = URI.parse(domain)
		request = Net::HTTP::Post.new(url.path)
		request.body = data.to_xml
		response = Net::HTTP.start(url.host, url.port) {|http| http.request(request)}
	end

end
