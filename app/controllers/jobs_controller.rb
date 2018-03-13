class JobsController < ApplicationController
  def home
    # flash[:success] = "Welcome to the Sample App!"
    @jobs = Job.where(state: 0)
  end

  def index
    page_num = params[:page] ? params[:page] : 1
    @jobs = Job.where(state: 0).page(page_num)
  end

  def search
    ScrapeIndeedJob.perform_now
    redirect_to jobs_path, flash: {success: "Success! Job Added to your jobs."}
  end
end
