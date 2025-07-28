class JobsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_company

  def index
    @jobs = @company.jobs
  end

  def new
    @job = @company.jobs.build
  end

  def create
    @job = @company.jobs.build(job_params)
    @job.account = current_user.account
    @job.user = current_user
    if @job.save
      redirect_to company_jobs_path(@company), notice: "Job created."
    else
      render :new
    end
  end

  def edit
    @job = @company.jobs.find(params[:id])
  end

  def update
    @job = @company.jobs.find(params[:id])
    if @job.update(job_params)
      redirect_to company_jobs_path(@company), notice: "Job updated."
    else
      render :edit
    end
  end

  def destroy
    @job = @company.jobs.find(params[:id])
    @job.destroy
    redirect_to company_jobs_path(@company), notice: "Job deleted."
  end

  def show
    @job = @company.jobs.find(params[:id])
  end

  private

  def set_company
    @company = Company.find(params[:company_id])
  end

  def job_params
    params.require(:job).permit(:title, :description, :requirements, :salary_range, :location, :job_type, :status)
  end
end
