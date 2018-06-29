class CompanyController < ApplicationController
  
  def create
    
    @company = Company.new("company_params")
    if @company.save
      current_user.companies << @company
      #render
    else
      #render
    end
  end

  def destroy
  
    company = Company.find(params[:id])
    company.destroy! if
    #redirect
  end

  def edit
    company = Company.find(params[:id])
    company.update_attribute(name: company_params[:name]) if company.creator_id == current_user.id
  end

  def add_user(username, company_id)
    user = User.find_by(username: username)
    company = User.find(company_id)
    if !user.nil? && !company.nil?
      user.companies << company
    else
      #render error
    end
  end

  def remove_user
    user = User.find_by(username: username)
    company = User.find(company_id)
    if !user.nil? && !company.nil?
      user.companies.delete company
    else
      #render error
    end
  end

  private
  def company_params
    params.require(:company).permit(:name)
  end

  def add_user_params
    params.require(:add_user).permit(:username)
  end
end
