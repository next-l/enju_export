require "spec_helper"

describe ExportFilesController do
  describe "routing" do

    it "routes to #index" do
      get("/export_files").should route_to("export_files#index")
    end

    it "routes to #new" do
      get("/export_files/new").should route_to("export_files#new")
    end

    it "routes to #show" do
      get("/export_files/1").should route_to("export_files#show", :id => "1")
    end

    it "routes to #edit" do
      get("/export_files/1/edit").should route_to("export_files#edit", :id => "1")
    end

    it "routes to #create" do
      post("/export_files").should route_to("export_files#create")
    end

    it "routes to #update" do
      put("/export_files/1").should route_to("export_files#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/export_files/1").should route_to("export_files#destroy", :id => "1")
    end

  end
end
