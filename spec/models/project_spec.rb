require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Project do
  before(:each) do
    @valid_attributes = {
      :user => User.find(50002),
      :name => "value for name",
      :custname => "value for custname",
      :budget => "1.5",
      :duedate => Time.now,
      :uuid => "11111111-2222-3333-4444-555555555555"
    }
  end

  it "should create a new instance given valid attributes" do
    Project.create!(@valid_attributes)
  end
  
  it "should return the my projects and manager projects for an user-account" do
    @user = User.find_by_id(50002)
    @user.myProjects.size.should equal(2)
  end
  it "should have a url for guest account" do
    
  end
end
