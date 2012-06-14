class UsersController < ApplicationController

  skip_before_filter :authenticate
  before_filter :authenticate_admin!

  def index
    @unapproved = User.where(:approved => false).order(:created_at)
    @users = User.where(:approved => true).order(:country)
  end

  def show
    @user = User.find(params[:id])
  end
end
