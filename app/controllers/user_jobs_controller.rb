class UserJobsController < ApplicationController
  def index
    flash[:success] = "Welcome to the Sample App!"
    @user_jobs = current_user.user_jobs
  end

  def new
    UserJob.create(user_id: current_user.id, job_id: params['job_id'])
    redirect_to jobs_path, flash: {success: "Success! Job Added to your jobs."}
  end
end
