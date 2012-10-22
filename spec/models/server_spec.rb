require 'spec_helper'

describe Server do
  it 'should call the getIP method before creating a new server' do
    @server = Server.new
    @server.should_receive(:getIp)
    @server.send(:create)
  end

  it 'should call the getIpInfo method from the getIp method' do
    @server = Server.new
    @server.ip = 'ip'
    @server.should_receive(:getIpInfo).with('ip').and_return(@server)
    @server.getIp == @server
  end
end
