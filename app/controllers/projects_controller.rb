class ProjectsController < ApplicationController
before_action :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
  	if params[:filter].present?
  		if params[:filter] == "recent"
  			@projects = Project.all.order('created_at DESC').paginate(:page => params[:page], per_page: 2)
  		elsif params[:filter] == "category_name"
  			@projects = Project.all.joins(:category).order('name ASC').paginate(:page => params[:page], per_page: 2)
  		elsif params[:filter] == "user_name"
  			@projects = Project.all.joins(:user).order('user_name ASC').paginate(:page => params[:page], per_page: 2)
  		elsif params[:filter] == "title"
  			@projects = Project.all.ordered_by_title.paginate(:page => params[:page], per_page: 2)
  		end
  	else
    	@projects = Project.all.order('created_at DESC').paginate(:page => params[:page], per_page: 2)
    end
    respond_to do |format|
	    format.html
	    format.json { render json: @projects }
	    format.js
	end
  end

  def show
  end

  def new
    @project = Project.new
    @categories = current_user.categories
  end

  def edit
    @categories = current_user.categories
  end

  def create
    @project = Project.new(project_params)
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    
    def set_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:title, :description, :category_id, :user_id)
    end
end

