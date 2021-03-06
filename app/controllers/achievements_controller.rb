class AchievementsController < ApplicationController
  # GET /achievements
  # GET /achievements.json
  def index
    redirect_to :controller => "websites", :action => "index"
  end

  # GET /achievements/1
  # GET /achievements/1.json
  def show
    @achievement = Achievement.find(params[:id])
    @awards = @achievement.awards
    @triggers_award = Trigger.all(:conditions => { :action => 1, :object => @achievement.id })
    @triggers_unaward = Trigger.all(:conditions => { :action => 0, :object => @achievement.id })
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => { @achievement.id => @achievement, :awarded => @awards } }
    end
  end

  # GET /achievements/new
  # GET /achievements/new.json
  def new
    @achievement = Achievement.new
    @websites = Website.all(:conditions => { :owner => current_user.id } )
    
    if (params[:website])
      @achievement.website_id = params[:website]
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @achievement }
    end
  end

  # GET /achievements/1/edit
  def edit
    @achievement = Achievement.find(params[:id])
  end

  # POST /achievements
  # POST /achievements.json
  def create
    @achievement = Achievement.new(params[:achievement])

    respond_to do |format|
      if @achievement.save
        format.html { redirect_to @achievement, notice: 'Achievement was successfully created.' }
        format.json { render json: @achievement, status: :created, location: @achievement }
      else
        format.html { render action: "new" }
        format.json { render json: @achievement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /achievements/1
  # PUT /achievements/1.json
  def update
    @achievement = Achievement.find(params[:id])

    respond_to do |format|
      if @achievement.update_attributes(params[:achievement])
        format.html { redirect_to @achievement, notice: 'Achievement was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @achievement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /achievements/1
  # DELETE /achievements/1.json
  def destroy
    @achievement = Achievement.find(params[:id])
    website = @achievement.website
    @achievement.destroy

    respond_to do |format|
      format.html { redirect_to website }
      format.json { head :no_content }
    end
  end
  
  def award
    @achievement = Achievement.find(params[:id])
    notice = ""
    params[:user_id].split(",").each do |to|
      notice_item = @achievement.award(to.strip)
      notice.concat("<li>" << notice_item << "</li>")
    end
    
    respond_to do |format|
      format.html { redirect_to @achievement, notice: '<ul>' << notice << '</ul>' }
      format.json { render json: @achievement, status: :awarded, location: @achievement } 
    end
  end
  
  def unaward
    @achievement = Achievement.find(params[:id])
    notice_text = @achievement.unaward(params[:user_id])
    
    respond_to do |format|
      format.html { redirect_to @achievement, notice: notice_text }
      format.json { head :no_content }
    end
  end
  
  def user_list
    @website = Website.find(params[:id])
    @user_id = params[:user_id]
    @awards = @website.awards.where(:to => @user_id)
    @records = @website.records.where(:user => @user_id)
    
    respond_to do |format|
      format.html # user_list.html.erb
      format.json { render :json => {:user => @user_id, :achievements => @awards, :records => @records } }
    end
  end
  
  def user_has_achievement
    @achievement = Achievement.find(params[:id])
    @user_id = params[:user_id]
    @awards = Award.count(:conditions => { :achievement_id => params[:id], :to => params[:user_id] } )
    
    respond_to do |format|
      format.html # user_has_achievement.html.erb
      format.json { render json: (@awards > 0) }
    end
  end
end
