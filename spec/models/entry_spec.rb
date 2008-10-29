require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

def valid_entry_attributes
  {
    :user => User.find(:first),
    :edate => '05/08/2008',
    :starttime => '10:00',
    :notes => "value for notes"
    }
end

describe Entry do
  before(:each) do
   @entry = Entry.new
  end

  it "should create a new instance given valid attributes" do
    @entry.attributes = valid_entry_attributes
  end
  
  it "should have an error on start time" do
    @entry.attributes = valid_entry_attributes.except(:starttime)
    @entry.should have(1).error_on(:starttime)
  end
  
  it "should have a starting date" do 
    @entry.attributes = valid_entry_attributes.except(:edate)
    @entry.should have(1).error_on(:edate)
  end 
  
  it "should have an error if user does not exist" do
    @entry.attributes = valid_entry_attributes.except(:user)
    @entry.should have(2).error_on(:user)
  end
  
  it "should have an error if endtime is before starttime" do
    @entry.attributes = valid_entry_attributes
    @entry.endtime   = '8:00'
    @entry.should have(1).error_on(:endtime)
  end


end
