require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/entries/new.html.erb" do
  include EntriesHelper
  
  before(:each) do
    assigns[:entry] = stub_model(Entry,
      :new_record? => true,
      :user => ,
      :follow => "1",
      :notes => "value for notes"
    )
  end

  it "should render new form" do
    render "/entries/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", entries_path) do
      with_tag("input#entry_user[name=?]", "entry[user]")
      with_tag("input#entry_follow[name=?]", "entry[follow]")
      with_tag("input#entry_notes[name=?]", "entry[notes]")
    end
  end
end


