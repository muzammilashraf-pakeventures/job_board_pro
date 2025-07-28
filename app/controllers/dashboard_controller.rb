class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  def index
    if current_user.super_admin?
      @companies = Company.includes(:jobs, :user)
      @jobs = Job.includes(:company, :user)
    else
      @companies = current_user.companies.includes(:jobs)
      @jobs = Job.where(company: @companies)
    end
  end

  private

  def authorize_admin!
    unless current_user.super_admin? || current_user.company_admin?
      redirect_to root_path, alert: "Access denied!"
    end
  end
end
