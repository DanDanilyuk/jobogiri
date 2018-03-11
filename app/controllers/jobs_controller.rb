class JobsController < ApplicationController
  def home
    # flash[:success] = "Welcome to the Sample App!"
    @jobs = Job.where(state: 0)
  end

  def index
    @jobs = Job.where(state: 0)
  end

  def search
    ScrapeIndeedJob.perform_now
    redirect_to root_path, flash: {success: "Success! Job Added to your jobs."}
  end
end
