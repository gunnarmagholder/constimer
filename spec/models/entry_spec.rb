require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Entry do
  before(:each) do
    @valid_attributes = {
      :user => ,
      :edate => Date.today,
      :starttime => Time.now,
      :endtime => Time.now,
      :follow => "1",
      :notes => "value for notes"
    }
  end

  it "should create a new instance given valid attributes" do
    Entry.create!(@valid_attributes)
  end
  
  it "should have a start time" 
  
  it "should have a starting date"
  
  it "should belong to a user"
  
  
end
