class UsersController < ApplicationController

  skip_before_filter :authenticate, :except => [:show]
  before_filter :authenticate_admin!, :except => [:show]

  def index
    @waiting = User.where(:approved => false).order(:created_at)
    @users = User.approved
    @admins = Admin.order(:name)
  end

  def show
    @user = User.includes(:reports).find(params[:id])
    @reports = @user.reports.order(:year)
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
end
