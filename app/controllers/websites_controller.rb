class WebsitesController < ApplicationController
  # GET /websites
  # GET /websites.json
  def index
    if signed_in?
      @websites = Website.find(:all, :conditions => { :owner => current_user.id } )
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @websites }
      end
    else
      redirect_to "/"
    end
  end

  # GET /websites/1
  # GET /websites/1.json
  def show
    @website = Website.find(params[:id])
    
    if @website.owner = current_user.id
      respond_to do |format|
        format.html # show.html.erb
        format.json { render :json => { @website.id => @website, :achievements => Achievement.find(:all, :conditions => { :website_id => @website.id }) } }
      end
    else
      format.html { redirect_to @website, notice: 'Error: You don\'t own that website.' }
      format.json { render json: @website.errors, status: 401 }
    end
  end

  # GET /websites/new
  # GET /websites/new.json
  def new
    @website = Website.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @website }
    end
  end

  # GET /websites/1/edit
  def edit
    @website = Website.find(params[:id])
    if @website.owner != current_user.id
      format.html { redirect_to @website, notice: 'Error: You don\'t own that website.' }
      format.json { render json: @website.errors, status: 401 }
    end
  end

  # POST /websites
  # POST /websites.json
  def create
    @website = Website.new(params[:website])
    @website.owner = current_user.id

    respond_to do |format|
      if @website.save
        format.html { redirect_to @website, notice: 'Website was successfully created.' }
        format.json { render json: @website, status: :created, location: @website }
      else
        format.html { render action: "new" }
        format.json { render json: @website.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /websites/1
  # PUT /websites/1.json
  def update
    @website = Website.find(params[:id])

    respond_to do |format|
      if @website.owner != current_user.id
        format.html { redirect_to @website, notice: 'Error: You don\'t own that website.' }
        format.json { render json: @website.errors, status: 401 }
      elsif @website.update_attributes(params[:website])
        format.html { redirect_to @website, notice: 'Website was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @website.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /websites/1
  # DELETE /websites/1.json
  def destroy
    @website = Website.find(params[:id])
    if @website.owner == current_user.id
      @website.destroy
    end

    respond_to do |format|
      format.html { redirect_to websites_url }
      format.json { head :no_content }
    end
  end
end
