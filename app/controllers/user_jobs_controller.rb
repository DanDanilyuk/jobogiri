class UserJobsController < ApplicationController
  def index
    # flash[:success] = "Welcome to the Sample App!"
    page_num = params[:page] ? params[:page] : 1
    @user_jobs = current_user.user_jobs.page(page_num).order(id: :desc)
  end

  def new
    UserJob.create(user_id: current_user.id, job_id: params['job_id'])
    redirect_to user_jobs_path, flash: {success: "Success! Job Added to your jobs."}
  end

  def show
    @user_job = current_user.user_jobs.find(params['id'])
  end

  def destroy
    current_user.user_jobs.where(job_id: params['id']).first.delete
    redirect_to user_jobs_path, flash: {success: "Success! Job Removed from your jobs."}
  end

  def edit
    @user_job = UserJob.find(params[:id])
  end

  def update
    @user_job = UserJob.find(params[:id])
    if @user_job.update(user_job_params)
      flash[:notice] = "UserJob successfully updated!"
      redirect_to user_jobs_path
    else
      render :edit
    end
  end

private
  def user_job_params
    params.require(:user_job).permit(:state, :comments)
  end
end
