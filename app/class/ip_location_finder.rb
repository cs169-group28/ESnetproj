class IpLocationFinder
  require 'open-uri'
  @key = '61acd0537857ef094869ff7dabe7571e6f800cb2a8a5e9dd5a5d8340f402982a'
  def get_ip(ip)
  file = open("http://api.ipinfodb.com/v3/ip-city/?key=#{@key}&ip=#{ip}")
    file.read.split(';').each do |part|
      puts part
    end
  end
end
