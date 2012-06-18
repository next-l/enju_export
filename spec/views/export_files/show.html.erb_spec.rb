require 'spec_helper'

describe "export_files/show" do
  before(:each) do
    @export_file = assign(:export_file, stub_model(ExportFile,
      :export_file_name => "Export File Name",
      :export_content_type => "Export Content Type",
      :export_file_size => "Export File Size",
      :state => "State"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Preparing/)
  end
end
