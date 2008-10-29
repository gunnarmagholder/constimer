require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Project do
  before(:each) do
    @valid_attributes = {
      :user => User.find(:first),
      :name => "value for name",
      :custname => "value for custname",
      :budget => "1.5",
      :duedate => Time.now
    }
  end

  it "should create a new instance given valid attributes" do
    Project.create!(@valid_attributes)
  end
end
