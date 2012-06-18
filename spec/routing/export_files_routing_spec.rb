require "spec_helper"

describe ExportFilesController do
  describe "routing" do

    it "routes to #index" do
      get("/export_files").should route_to("export_files#index")
    end

    it "routes to #show" do
      get("/export_files/1").should route_to("export_files#show", :id => "1")
    end

    it "routes to #destroy" do
      delete("/export_files/1").should route_to("export_files#destroy", :id => "1")
    end

  end
end
