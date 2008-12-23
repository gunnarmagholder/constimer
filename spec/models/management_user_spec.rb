# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '/../spec_helper'

include AuthenticatedTestHelper


describe User do
  before(:each) do
    @user1_valid = {
      :id                       => 50001,
      :login                    => 'rudolph',
      :email                    => 'rudolph@example.com',
      :salt                     => '356a192b7913b04c54574d18c28d46e6395428ab',
      :crypted_password         => 'df42adbd0b4f7d31af495bcd170d4496686aecb1',
      :user_type                => 'SiteUser',
      :remember_token           => '77de68daecd823babbb58edb1c8e14d7106e83bb' 
    }
    @user2_valid = {
      :id                       => 50002,
      :login                    => 'Claus',
      :email                    => 'Claus@example.com',
      :salt                     => '356a192b7913b04c54574d18c28d46e6395428ab',
      :crypted_password         => 'df42adbd0b4f7d31af495bcd170d4496686aecb1',
      :user_type                => 'SiteUser',
      :remember_token           => '77de68daecd823babbb58edb1c8e14d7106e83bb',
      :managed_by               => 50001 
    }
    @user3_valid = {
      :id                       => 50003,
      :login                    => 'Grinch',
      :email                    => 'Grinch@example.com',
      :salt                     => '356a192b7913b04c54574d18c28d46e6395428ab',
      :crypted_password         => 'df42adbd0b4f7d31af495bcd170d4496686aecb1',
      :user_type                => 'SiteUser',
      :remember_token           => '77de68daecd823babbb58edb1c8e14d7106e83bb' 
    }
    @user1=User.new(@user1_valid)
    @user1.save
    @user2=User.new(@user2_valid)
    @user2.save
    @user3=User.new(@user3_valid)
    @user3.save
  end
  it "should construct a valid user" do
    @user1.login.should eql('rudolph')
  end
  it "should not complain if managed_by is nil" do
    @user3.managed_by.should be_nil
  end
  it "should allow only management users as managed_by users" do
    
  end
  it "should throw an error if managed_by user does not exist" do
  end
end
