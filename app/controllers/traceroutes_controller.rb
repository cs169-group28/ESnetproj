class TraceroutesController < ApplicationController
  # GET /traceroutes
  # GET /traceroutes.json

  require 'json'

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
    redirect_to render_map_traceroute_path(params[:Server]['1'], params[:Server]['2'])
  end

  def render_map
    @s1 = Server.find(params[:server1])
    @s2 = Server.find(params[:server2])
    s = Array.new
    s.push(@s1, @s2)
    @json = s.to_gmaps4rails
    @polylines_json = '[' + @json + ']'
    polylines_hash = JSON.parse @polylines_json
    polylines_hash[0][0]["geodesic"] = true
    @polylines_json = polylines_hash.to_json
    puts @polylines_json

  end

end
