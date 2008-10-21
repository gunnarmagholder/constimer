require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe EntriesController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "entries", :action => "index").should == "/entries"
    end
  
    it "should map #new" do
      route_for(:controller => "entries", :action => "new").should == "/entries/new"
    end
  
    it "should map #show" do
      route_for(:controller => "entries", :action => "show", :id => 1).should == "/entries/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "entries", :action => "edit", :id => 1).should == "/entries/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "entries", :action => "update", :id => 1).should == "/entries/1"
    end
  
    it "should map #destroy" do
      route_for(:controller => "entries", :action => "destroy", :id => 1).should == "/entries/1"
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/entries").should == {:controller => "entries", :action => "index"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/entries/new").should == {:controller => "entries", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/entries").should == {:controller => "entries", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/entries/1").should == {:controller => "entries", :action => "show", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/entries/1/edit").should == {:controller => "entries", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/entries/1").should == {:controller => "entries", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/entries/1").should == {:controller => "entries", :action => "destroy", :id => "1"}
    end
  end
end
