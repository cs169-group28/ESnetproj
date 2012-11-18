class Server < ActiveRecord::Base
  attr_accessible :hostname, :ip

  before_update :getIp

  require 'open-uri'
  require 'socket'

  def getIp
    if self.ip.blank?
      self.ip = IPSocket::getaddress(self.hostname)
    end
  end

end
