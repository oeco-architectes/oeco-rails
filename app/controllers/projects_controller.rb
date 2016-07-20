class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    puts params.inspect
    @project = Project.find_by_slug(params[:id])
  end
end
