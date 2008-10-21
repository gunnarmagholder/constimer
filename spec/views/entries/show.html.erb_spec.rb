require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/entries/show.html.erb" do
  include EntriesHelper
  
  before(:each) do
    assigns[:entry] = @entry = stub_model(Entry,
      :user => ,
      :follow => "1",
      :notes => "value for notes"
    )
  end

  it "should render attributes in <p>" do
    render "/entries/show.html.erb"
    response.should have_text(//)
    response.should have_text(/1/)
    response.should have_text(/value\ for\ notes/)
  end
end

