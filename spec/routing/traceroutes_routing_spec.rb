require "spec_helper"

describe TraceroutesController do
  describe "routing" do

    it "routes to #index" do
      get("/traceroutes").should route_to("traceroutes#index")
    end

    it "routes to #new" do
      get("/traceroutes/new").should route_to("traceroutes#new")
    end

    it "routes to #show" do
      get("/traceroutes/1").should route_to("traceroutes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/traceroutes/1/edit").should route_to("traceroutes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/traceroutes").should route_to("traceroutes#create")
    end

    it "routes to #update" do
      put("/traceroutes/1").should route_to("traceroutes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/traceroutes/1").should route_to("traceroutes#destroy", :id => "1")
    end

  end
end
