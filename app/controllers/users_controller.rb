class UsersController < ApplicationController

  skip_before_filter :authenticate
  before_filter :authenticate_admin!

  def index
    @waiting = User.where(:approved => false).order(:created_at)
    @users = User.approved
    @admins = Admin.order(:name)
  end

  def show
    @user = User.find(params[:id])
  end

  def approve
    @user = User.find(params[:id])
    if @user.update_attribute(:approved, true)
      #email user
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
