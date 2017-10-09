class ProjectsController < ApplicationController
  def create
    if policy.allowed?
      @project = Project.create!(project_params)
      render json: @project, status: :created
    else
      head :unauthorized
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :description)
  end

  def policy
    CreateProjectPolicy.new(current_user, redis)
  end

  def redis
    Redis.current
  end
end

class User < ActiveRecord::Base
  enum role: [:manager, :employee, :guest]
end

class CreateProjectPolicy
  def initialize(user, redis_client)
    @user = user
    @redis_client = redis_client
  end

  def allowed?
    @user.manager? && below_project_limit && !project_creation_blocked
  end

  private

  def below_project_limit
    @user.projects.count < Project.max_count
  end

  def project_creation_blocked
    @redis_client.get('projects_creation_blocked') == '1'
  end
end

