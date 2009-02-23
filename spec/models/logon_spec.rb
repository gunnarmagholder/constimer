require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Logon do
  before(:each) do
    @valid_attributes = {
      :user => "1",
    }
    @logon = Logon.create!(@valid_attributes)
  end
  

  it "should create a new instance given valid attributes" do
    @logon.should be_valid
  end
  
  it "should only contain records for valid users" do
    User.find(@logon.user).should be_valid
  end
  
  it "should delete an old logon record if user logs on again" do
    
  end
  
end
