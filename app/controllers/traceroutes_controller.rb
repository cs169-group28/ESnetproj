class TraceroutesController < ApplicationController
  # GET /traceroutes
  # GET /traceroutes.json
  def index
    @traceroutes = Traceroute.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @traceroutes }
    end
  end

  # GET /traceroutes/1
  # GET /traceroutes/1.json
  def show
    @traceroute = Traceroute.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @traceroute }
    end
  end

  # GET /traceroutes/new
  # GET /traceroutes/new.json
  def new
    @traceroute = Traceroute.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @traceroute }
    end
  end

  # GET /traceroutes/1/edit
  def edit
    @traceroute = Traceroute.find(params[:id])
  end

  # POST /traceroutes
  # POST /traceroutes.json
  def create
    @traceroute = Traceroute.new(params[:traceroute])

    respond_to do |format|
      if @traceroute.save
        format.html { redirect_to @traceroute, notice: 'Traceroute was successfully created.' }
        format.json { render json: @traceroute, status: :created, location: @traceroute }
      else
        format.html { render action: "new" }
        format.json { render json: @traceroute.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /traceroutes/1
  # PUT /traceroutes/1.json
  def update
    @traceroute = Traceroute.find(params[:id])

    respond_to do |format|
      if @traceroute.update_attributes(params[:traceroute])
        format.html { redirect_to @traceroute, notice: 'Traceroute was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @traceroute.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /traceroutes/1
  # DELETE /traceroutes/1.json
  def destroy
    @traceroute = Traceroute.find(params[:id])
    @traceroute.destroy

    respond_to do |format|
      format.html { redirect_to traceroutes_url }
      format.json { head :no_content }
    end
  end
end
