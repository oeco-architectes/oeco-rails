# frozen_string_literal: true

# Projects list and project details pages controller
class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find_by(slug: params[:id])
  end
end
