class JobsController < ApplicationController
  def home
    ScrapeIndeedJob.perform_now
  end
end
