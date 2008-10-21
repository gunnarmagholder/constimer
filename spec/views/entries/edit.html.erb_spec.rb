require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/entries/edit.html.erb" do
  include EntriesHelper
  
  before(:each) do
    assigns[:entry] = @entry = stub_model(Entry,
      :new_record? => false,
      :user => ,
      :follow => "1",
      :notes => "value for notes"
    )
  end

  it "should render edit form" do
    render "/entries/edit.html.erb"
    
    response.should have_tag("form[action=#{entry_path(@entry)}][method=post]") do
      with_tag('input#entry_user[name=?]', "entry[user]")
      with_tag('input#entry_follow[name=?]', "entry[follow]")
      with_tag('input#entry_notes[name=?]', "entry[notes]")
    end
  end
end


