class AdminsController < ApplicationController

  def new
    @admin = Admin.new(:approved => true)
  end

  def create
    @admin = Admin.new(params[:admin])
    if @admin.save
      respond_to do |format|
        format.html { redirect_to users_path }
      end
    else
      render :action => :new
    end
  end
end
