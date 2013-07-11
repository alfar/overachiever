class TriggersController < ApplicationController
  # GET /triggers
  # GET /triggers.json
  def index
    @triggers = Trigger.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @triggers }
    end
  end

  # GET /triggers/1
  # GET /triggers/1.json
  def show
    @trigger = Trigger.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @trigger }
    end
  end

  # GET /triggers/new
  # GET /triggers/new.json
  def new
    @trigger = Trigger.new
    @websites = Website.all(:conditions => { :owner => current_user.id } )
    
    if (params[:tracker])
      @trigger.tracker_id = params[:tracker]
    end
    
    if (params[:object])
      @achievement = Achievement.find(params[:object])
      if @achievement
        @trigger.object = @achievement.id
      end
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @trigger }
    end
  end

  # GET /triggers/1/edit
  def edit
    @trigger = Trigger.find(params[:id])
    @websites = Website.all(:conditions => { :owner => current_user.id } )
  end

  # POST /triggers
  # POST /triggers.json
  def create
    @trigger = Trigger.new(params[:trigger])

    respond_to do |format|
      if @trigger.save
        format.html { redirect_to @trigger.tracker, notice: 'Trigger was successfully created.' }
        format.json { render json: @trigger, status: :created, location: @trigger }
      else
        format.html { render action: "new" }
        format.json { render json: @trigger.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /triggers/1
  # PUT /triggers/1.json
  def update
    @trigger = Trigger.find(params[:id])

    respond_to do |format|
      if @trigger.update_attributes(params[:trigger])
        format.html { redirect_to @trigger.tracker, notice: 'Trigger was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @trigger.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /triggers/1
  # DELETE /triggers/1.json
  def destroy
    @trigger = Trigger.find(params[:id])
    @tracker = Tracker.find(@trigger.tracker_id)
    @trigger.destroy

    respond_to do |format|
      format.html { redirect_to @tracker }
      format.json { head :no_content }
    end
  end
end
