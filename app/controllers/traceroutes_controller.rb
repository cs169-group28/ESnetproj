class TraceroutesController < ApplicationController
  # GET /traceroutes
  # GET /traceroutes.json

  require 'json'
  require 'xmlsimple'
  require 'net/http'
  require 'uri'
  require 'socket'

  def index
    @servers = Server.all

  end

  # GET /traceroutes/1
  # GET /traceroutes/1.json
  def show

  end

  # GET /traceroutes/new
  # GET /traceroutes/new.json
  def new

  end

  # GET /traceroutes/1/edit
  def edit

  end

  # POST /traceroutes
  # POST /traceroutes.json
  def create

  end

  # PUT /traceroutes/1
  # PUT /traceroutes/1.json
  def update

  end

  # DELETE /traceroutes/1
  # DELETE /traceroutes/1.json
  def destroy

  end

  def handle_render
    p "=========shit"
    p params[:Timeframe]
    p "HERERERERERERdfsfd==========================aefh;kjaewfh;iaewhf;aewhb;fiqwh;eifh;iufh"

    redirect_to render_map_traceroute_path(params[:Requesttype]['3'], params[:Server]['1'], params[:Server]['2'], params[:Timeframe]['4'])
  end

  def render_map
    @s1 = Server.find(params[:server1])
    @s2 = Server.find(params[:server2])
    @request_type = params[:requesttype]
    @time_frame = params[:timeframe]
    p "=================shitcock==============="
    p params
    s = Array.new
    s.push(@s1, @s2)
    @src = IPSocket::getaddress(@s1.hostname)
    @dst = IPSocket::getaddress(@s2.hostname)

    if @request_type == "OWAMP"
      # Convert hostnames to IP address only for OWAMP
      @response = Perfsonar.requestOwampData(@src, @dst, @time_frame)
    elsif @request_type == "BWCTL"
      
      @response = Perfsonar.requestBwctlData(@s1.hostname, @s2.hostname, @time_frame)
    else
      @response = Perfsonar.requestTracerouteData(@s1.hostname, @s2.hostname, @time_frame)
      
      @masterNodes = @response[3]
      @masterMatrix = @response[2]
      @masterHash = @response[1]
      @response = @response[0]
      @nodes = Hash[@response.collect { |a| [a[:hop], a[:value]] }]
    end
   
  end

end
