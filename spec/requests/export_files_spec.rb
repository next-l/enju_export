require 'spec_helper'

describe "ExportFiles" do
  describe "GET /export_files" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get export_files_path
      response.status.should be(302)
    end
  end
end
