require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do

  before(:each) do
    @manager = User.find(50001)
    @user = User.find(50002)
  end

  it "should return the my projects and manager projects for an user-account" do
    @user.myProjects.size.should equal(3)
  end
  
  it "should return the manager projects and all colleagues (except private projects) for a manager account" do
    @manager.myProjects.size.should equal(2)
  end
    
end
