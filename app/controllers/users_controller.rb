class UsersController < ApplicationController

  skip_before_filter :authenticate, :except => [:show]
  before_filter :authenticate_admin!, :except => [:show, :has_report]

  def index
    @waiting = User.where(:approved => false).order(:created_at)
    @users = User.approved
    @admins = Admin.order(:name)
  end

  def show
    @user = User.includes(:reports).find(params[:id])
    @reports = Report.order('year DESC').joins(:user).where(:users => {:country_id => @user.country_id})
  end

  def approve
    @user = User.find(params[:id])
    if @user.update_attribute(:approved, true)
      UserMailer.user_approved(@user).deliver
      flash[:notice] = "User has been approved"
      respond_to do |format|
        format.js
      end
    end
  end

  def disapprove
    @user = User.find(params[:id])
    if @user.update_attribute(:approved, false)
      #email user
      flash[:notice] = "User has been disapproved"
      respond_to do |format|
        format.js
      end
    end
  end

  def has_report
    user = current_user
    result = params[:year].present? ? Report.joins(:user).where(:year => params[:year], :users => {:country_id => current_user.country_id}).first.try(:id) || -1  : -1
    render :json => result
  end
end
