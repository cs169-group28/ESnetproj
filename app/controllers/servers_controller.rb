class ServersController < ApplicationController
 before_filter :require_user
  # GET /servers
  # GET /servers.json

  @@categoriesList = ["Core Hosts", "Edge Hosts", "Exchange Points", "Smaller DOE Sites", "DICE Testing", "Main Hubs", "Large BWCTL DOE Sites", "Other BWCTL Hubs", "1G Testers", "OWAMP", "BWCTL", "TRACEROUTE"]

 

  def index
    @servers = Server.all

    end
  end

  # GET /servers/1
  # GET /servers/1.json
  def show
    @server = Server.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @server }
    end
  end

  # GET /servers/new
  # GET /servers/new.json
  def new
    @server = Server.new
    @categoriesList = ["Core Hosts", "Edge Hosts", "Exchange Points", "Smaller DOE Sites", "DICE Testing", "Main Hubs", "Large BWCTL DOE Sites", "Other BWCTL Hubs", "1G Testers", "OWAMP", "BWCTL", "TRACEROUTE"]
    
    if @server.categories != nil
       @checkedCategoriesList = @server.categories.split("\n- ")
       @checkedCategoriesList.each do |shit|
         @newArray << shit.rstrip
       end
       @checkedCategoriesList = @newArray
    else 
       @checkedCategoriesList = []
    end
 
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @server }
    end
  end

  # GET /servers/1/edit
  def edit
    @server = Server.find(params[:id])

    @categoriesList = ["Core Hosts", "Edge Hosts", "Exchange Points", "Smaller DOE Sites", "DICE Testing", "Main Hubs", "Large BWCTL DOE Sites", "Other BWCTL Hubs", "1G Testers", "OWAMP", "BWCTL", "TRACEROUTE"]
    
    @newArray = []
    if @server.categories != nil
      @checkedCategoriesList = @server.categories.split("\n- ")
      @checkedCategoriesList.each do |shit|
        @newArray << shit.rstrip
      end
      @checkedCategoriesList = @newArray
    else 
      @checkedCategoriesList = []
    end

  end

  # POST /servers
  # POST /servers.json
  def create
    @server = Server.new(:hostname => params[:server][:hostname], :ip => params[:server][:ip])

    updateCategories

    respond_to do |format|
      if @server.save
        format.html { redirect_to @server, notice: 'Server was successfully created.' }
        format.json { render json: @server, status: :created, location: @server }
      else
        format.html { render action: "new" }
        format.json { render json: @server.errors, status: :unprocessable_entity }
      end
    end
  end

  def updateCategories
    @newCategoryList = []
    

    @@categoriesList.each do |category|
      if params[:server][category] == "1"
        @newCategoryList << category
      end
    end

    

    @server.categories = @newCategoryList
    @server.save
  end

  # PUT /servers/1
  # PUT /servers/1.json
  def update
    @server = Server.find(params[:id])

    updateCategories

    respond_to do |format|
      if @server.update_attributes(:hostname => params[:server][:hostname], :ip => params[:server][:ip])

        format.html { redirect_to @server, notice: 'Server was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @server.errors, status: :unprocessable_entity }
      end
    end

    
  end

  # DELETE /servers/1
  # DELETE /servers/1.json
  def destroy
    @server = Server.find(params[:id])
    @server.destroy

    respond_to do |format|
      format.html { redirect_to servers_url }
      format.json { head :no_content }
    end
  end
end
