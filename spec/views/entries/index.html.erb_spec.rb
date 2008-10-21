require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/entries/index.html.erb" do
  include EntriesHelper
  
  before(:each) do
    assigns[:entries] = [
      stub_model(Entry,
        :user => ,
        :follow => "1",
        :notes => "value for notes"
      ),
      stub_model(Entry,
        :user => ,
        :follow => "1",
        :notes => "value for notes"
      )
    ]
  end

  it "should render list of entries" do
    render "/entries/index.html.erb"
    response.should have_tag("tr>td", , 2)
    response.should have_tag("tr>td", "1", 2)
    response.should have_tag("tr>td", "value for notes", 2)
  end
end

