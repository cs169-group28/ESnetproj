class Server < ActiveRecord::Base
  attr_accessible :city, :country, :ip, :latitude, :longitude, :name, :state, :zip

  before_create :getIp
  acts_as_gmappable :process_geocoding => false

  require 'open-uri'


  def gmaps4rails_address
    {latitude:self.latitude, longitude:self.longitude}
  end

  def getIpInfo(ip)
  @key = '61acd0537857ef094869ff7dabe7571e6f800cb2a8a5e9dd5a5d8340f402982a'
    file = open("http://api.ipinfodb.com/v3/ip-city/?key=#{@key}&ip=#{ip}")
    file.read.split(';')
  end

  def getIp
    ipInfo = getIpInfo(self.ip)
    self.country = ipInfo[4]
    self.city = ipInfo[6]
  self.state = ipInfo[5]
  self.zip = ipInfo[7]
  self.latitude = ipInfo[8]
  self.longitude = ipInfo[9]

  end

end
