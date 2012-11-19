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
    redirect_to render_map_traceroute_path(params[:Requesttype]['3'], params[:Server]['1'], params[:Server]['2'])
  end

  def render_map
    @s1 = Server.find(params[:server1])
    @s2 = Server.find(params[:server2])
    @request_type = params[:requesttype]
    s = Array.new
    s.push(@s1, @s2)

    if @request_type == "OWAMP"
      # Convert hostnames to IP address only for OWAMP
      src = IPSocket::getaddress(@s1.hostname)
      dst = IPSocket::getaddress(@s2.hostname)
      @response = Perfsonar.requestOwampData(src, dst)
    elsif @request_type == "BWCTL"
      
      @response = Perfsonar.requestBwctlData(@s1.hostname, @s2.hostname)
    else
      @response = Perfsonar.requestTracerouteData(@s1.hostname, @s2.hostname)
      @nodes = Hash[@response.collect { |a| [a[:hop], a[:value]] }]
    end
   
  end

end
