class JobsController < ApplicationController
  def home
    @jobs = Job.all
    # ScrapeIndeedJob.perform_now
  end
end