require 'spec_helper'

describe "export_files/new" do
  before(:each) do
    assign(:export_file, stub_model(ExportFile,
      :export_file_name => "MyString",
      :export_content_type => "MyString",
      :export_file_size => "MyString",
      :state => "MyString"
    ).as_new_record)
  end

  it "renders new export_file form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => export_files_path, :method => "post" do
      assert_select "input#export_file_export_file_name", :name => "export_file[export_file_name]"
      assert_select "input#export_file_export_content_type", :name => "export_file[export_content_type]"
      assert_select "input#export_file_export_file_size", :name => "export_file[export_file_size]"
      assert_select "input#export_file_state", :name => "export_file[state]"
    end
  end
end
