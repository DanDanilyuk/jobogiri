class JobsController < ApplicationController
  def home
    flash[:success] = "Welcome to the Sample App!"
    @jobs = Job.all
  end

  def index
    @jobs = Job.all
  end

  def search
    ScrapeIndeedJob.perform_now
    redirect_to root_path, flash: {success: "Success! Job Added to your jobs."}
  end
end
