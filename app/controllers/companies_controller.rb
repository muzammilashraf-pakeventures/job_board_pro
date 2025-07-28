class CompaniesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  def index
    @companies = current_user.super_admin? ? Company.all : current_user.companies
  end

  def new
    @company = current_user.companies.build
  end

  def create
    @company = current_user.companies.build(company_params)
    @company.account = current_user.account
    if @company.save
      redirect_to @company, notice: "Company created successfully."
    else
      render :new
    end
  end

  def show
    @company = Company.find(params[:id])
  end

  def edit
    @company = find_company(params[:id])
  end

  def update
    @company = find_company(params[:id])
    if @company.update(company_params)
      redirect_to @company, notice: "Company updated."
    else
      render :edit
    end
  end

  def destroy
    @company = find_company(params[:id])
    @company.destroy
    redirect_to companies_path, notice: "Company deleted."
  end

  private

  def company_params
    params.require(:company).permit(:name, :description, :website, :location)
  end

  def authorize_admin!
    redirect_to root_path unless current_user.super_admin? || current_user.company_admin?
  end

  #  Handles both super_admin and company_admin access
  def find_company(id)
    if current_user.super_admin?
      Company.find(id)
    else
      current_user.companies.find(id)
    end
  end
end
