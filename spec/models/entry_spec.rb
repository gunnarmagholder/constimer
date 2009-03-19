require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'factory_girl'

def valid_entry_attributes
  {
    :user => User.find_by_login("aaron"),
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
  
  it "should return zero if there is no endtime" do
    @entry.attributes = valid_entry_attributes
    @entry.minutes.should be_nil
  end
  
  it "should return the correct differnce between start and endtime in minutes" do
    @entry.attributes = valid_entry_attributes
    @entry.endtime = "11:00"
    @entry.minutes_calculated.should == 60
  end
  
  it "should return only the time-difference" do
    @entry.attributes = valid_entry_attributes
    @entry.starttime = '2009-03-01 10:00'
    @entry.endtime = '2010-03-01 10:30'
    @entry.minutes_calculated.should == 30
  end

  it "should return the right date" do
    @entry.attributes = valid_entry_attributes
    @entry.edate = '1.3.2009'
    @entry.edate.month.should == 3
    @entry.edate.day.should == 1
    @entry.edate.year.should == 2009
    @entry.edate = '03/01/2009'
    @entry.edate.month.should == 3
    @entry.edate.day.should == 1
    @entry.edate.year.should == 2009
  end
  
  it "should throw an error if year is only two digits" do
    @entry.attributes = valid_entry_attributes.except(:edate)
    @entry.edate = '1.3.09'
    @entry.edate.year.to_i.should == 2009
    @entry.should have(1).error_on(:edate)
  end

end


