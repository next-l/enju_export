require 'spec_helper'

describe "export_files/index" do
  before(:each) do
    assign(:export_files, [
      stub_model(ExportFile,
        :export_file_name => "Export File Name",
        :export_content_type => "Export Content Type",
        :export_file_size => "Export File Size",
        :state => "State"
      ),
      stub_model(ExportFile,
        :export_file_name => "Export File Name",
        :export_content_type => "Export Content Type",
        :export_file_size => "Export File Size",
        :state => "State"
      )
    ])
  end

  it "renders a list of export_files" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Export File Name".to_s, :count => 2
    assert_select "tr>td", :text => "Export Content Type".to_s, :count => 2
    assert_select "tr>td", :text => "Export File Size".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
  end
end
