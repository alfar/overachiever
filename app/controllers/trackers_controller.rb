class TrackersController < ApplicationController
  # GET /trackers
  # GET /trackers.json
  def index
    @trackers = Tracker.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @trackers }
    end
  end

  # GET /trackers/1
  # GET /trackers/1.json
  def show
    @tracker = Tracker.find(params[:id])
    @records = @tracker.records
    @triggers = @tracker.triggers

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => { @tracker.id => @tracker, :records => @records } }
    end
  end

  # GET /trackers/new
  # GET /trackers/new.json
  def new
    @tracker = Tracker.new
    @websites = Website.all(:conditions => { :owner => current_user.id } )
    
    if (params[:website])
      @tracker.website_id = params[:website]
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tracker }
    end
  end

  # GET /trackers/1/edit
  def edit
    @tracker = Tracker.find(params[:id])
  end

  # POST /trackers
  # POST /trackers.json
  def create
    @tracker = Tracker.new(params[:tracker])

    respond_to do |format|
      if @tracker.save
        format.html { redirect_to @tracker, notice: 'Tracker was successfully created.' }
        format.json { render json: @tracker, status: :created, location: @tracker }
      else
        format.html { render action: "new" }
        format.json { render json: @tracker.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /trackers/1
  # PUT /trackers/1.json
  def update
    @tracker = Tracker.find(params[:id])

    respond_to do |format|
      if @tracker.update_attributes(params[:tracker])
        format.html { redirect_to @tracker, notice: 'Tracker was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tracker.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trackers/1
  # DELETE /trackers/1.json
  def destroy
    @tracker = Tracker.find(params[:id])
    website = @tracker.website
    @tracker.destroy

    respond_to do |format|
      format.html { redirect_to website }
      format.json { head :no_content }
    end
  end
  
  def record
    @tracker = Tracker.find(params[:id])
    notice = @tracker.record(params[:user_id])
    @record = @tracker.records.where(:user => params[:user_id])
    
    respond_to do |format|
      format.html { redirect_to @tracker, notice: '<ul>' << notice << '</ul>' }
      format.json { render json: @record, status: :recorded, location: @tracker } 
    end
  end
  
  def reset
    @tracker = Tracker.find(params[:id])
    Record.destroy_all(:tracker_id => params[:id], :user => params[:user_id])
    notice = "Record for " + params[:user_id] + " destroyed."
    
    respond_to do |format|
      format.html { redirect_to @tracker, notice: notice }
      format.json { render json: @tracker, status: :reset, location: @tracker } 
    end
  end
end
