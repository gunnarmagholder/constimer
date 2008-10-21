require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe EntriesController do

  def mock_entry(stubs={})
    @mock_entry ||= mock_model(Entry, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all entries as @entries" do
      Entry.should_receive(:find).with(:all).and_return([mock_entry])
      get :index
      assigns[:entries].should == [mock_entry]
    end

    describe "with mime type of xml" do
  
      it "should render all entries as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Entry.should_receive(:find).with(:all).and_return(entries = mock("Array of Entries"))
        entries.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested entry as @entry" do
      Entry.should_receive(:find).with("37").and_return(mock_entry)
      get :show, :id => "37"
      assigns[:entry].should equal(mock_entry)
    end
    
    describe "with mime type of xml" do

      it "should render the requested entry as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Entry.should_receive(:find).with("37").and_return(mock_entry)
        mock_entry.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new entry as @entry" do
      Entry.should_receive(:new).and_return(mock_entry)
      get :new
      assigns[:entry].should equal(mock_entry)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested entry as @entry" do
      Entry.should_receive(:find).with("37").and_return(mock_entry)
      get :edit, :id => "37"
      assigns[:entry].should equal(mock_entry)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created entry as @entry" do
        Entry.should_receive(:new).with({'these' => 'params'}).and_return(mock_entry(:save => true))
        post :create, :entry => {:these => 'params'}
        assigns(:entry).should equal(mock_entry)
      end

      it "should redirect to the created entry" do
        Entry.stub!(:new).and_return(mock_entry(:save => true))
        post :create, :entry => {}
        response.should redirect_to(entry_url(mock_entry))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved entry as @entry" do
        Entry.stub!(:new).with({'these' => 'params'}).and_return(mock_entry(:save => false))
        post :create, :entry => {:these => 'params'}
        assigns(:entry).should equal(mock_entry)
      end

      it "should re-render the 'new' template" do
        Entry.stub!(:new).and_return(mock_entry(:save => false))
        post :create, :entry => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested entry" do
        Entry.should_receive(:find).with("37").and_return(mock_entry)
        mock_entry.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :entry => {:these => 'params'}
      end

      it "should expose the requested entry as @entry" do
        Entry.stub!(:find).and_return(mock_entry(:update_attributes => true))
        put :update, :id => "1"
        assigns(:entry).should equal(mock_entry)
      end

      it "should redirect to the entry" do
        Entry.stub!(:find).and_return(mock_entry(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(entry_url(mock_entry))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested entry" do
        Entry.should_receive(:find).with("37").and_return(mock_entry)
        mock_entry.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :entry => {:these => 'params'}
      end

      it "should expose the entry as @entry" do
        Entry.stub!(:find).and_return(mock_entry(:update_attributes => false))
        put :update, :id => "1"
        assigns(:entry).should equal(mock_entry)
      end

      it "should re-render the 'edit' template" do
        Entry.stub!(:find).and_return(mock_entry(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested entry" do
      Entry.should_receive(:find).with("37").and_return(mock_entry)
      mock_entry.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the entries list" do
      Entry.stub!(:find).and_return(mock_entry(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(entries_url)
    end

  end

end
