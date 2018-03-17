class JobsController < ApplicationController
  def home
    # flash[:success] = "Welcome to the Sample App!"
    @jobs = Job.where(state: 0)
  end

  def index
    page_num = params[:page] ? params[:page] : 1
    @jobs = Job.where(state: 0).order(id: :desc).page(page_num)
  end

  def show
    @job = Job.find(params['id'])
  end
end
