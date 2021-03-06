class EntriesController < ApplicationController
  before_filter :login_required
  
  # GET /entries
  # GET /entries.xml
  
  def index
    # @entries = Entry.find(:all, :conditions => ['user_id = ? and project_ID IS NOT NULL', current_user.id ], :order => "edate DESC", :limit => 10, :include => :project)
    @entries = Entry.paginate :per_page => 10, :page => params[:page], :order => "edate DESC",
                              :conditions => ['user_id = ? and project_ID IS NOT NULL ', current_user.id ]
    respond_to do |format|
      format.html
      format.xml  { render :xml => @entries }
    end
  end

  def show_all
  	@entries = Entry.find(:all, :conditions => ['user_id = ? and project_ID IS NOT NULL', current_user.id ], :order => "edate DESC", :include => :project)
  	respond_to do |format|
  		format.js
  	end
  end


  def incomplete
  	@entries = Entry.find(:all, :conditions => ['user_id = ? and project_ID IS NOT NULL and endtime is NULL', current_user.id ], :order => "edate DESC", :include => :project)
  	respond_to do |format|
  		format.js
  	end
  end

  # GET /entries/1
  # GET /entries/1.xml
  def show
    @entry = Entry.find(:all, :conditions => ['user_id = ? AND id = ?',current_user.id,params[:id]]).first
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @entry }
    end
  end

  # GET /entries/new
  # GET /entries/new.xml
  def new
    @entry = Entry.new
    @entry = Date.today  
    @entry.edate = Date.today
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @entry }
    end
  end

  # GET /entries/1/edit
  def edit
    @entry = Entry.find(params[:id]) 
  end

  # POST /entries
  # POST /entries.xml
  def create
    @entry = Entry.new(params[:entry])
    @entry.user = current_user
    respond_to do |format|
      if @entry.save
        flash[:notice] = 'Entry was successfully created.'
        format.html { redirect_to entries_path }
        format.js 
        format.xml  { render :xml => @entry, :status => :created, :location => @entry }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /entries/1
  # PUT /entries/1.xml
  def update
    @entry = Entry.find(params[:id])
    @entry.user = current_user
    respond_to do |format|
      if @entry.update_attributes(params[:entry])
        flash[:notice] = 'Entry was successfully updated.'
        format.html { redirect_to(@entry) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.xml
  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy

    respond_to do |format|
      format.html { redirect_to(entries_url) }
      format.xml  { head :ok }
    end
  end
  
  def stop
    @entry = Entry.find(params[:id])
    @entry.update_attribute :endtime, Time.now.hour.to_s + ":" + Time.now.min.to_s
    @entry.minutes = @entry.minutes_calculated
    flash[:notice] = "Endtime entered..."
    redirect_to entries_path
  end
  
  def incompleted
     @entries = Entry.find(:all, :conditions => ['user_id = ? and endtime IS NULL', current_user.id ])
  end
  
end
