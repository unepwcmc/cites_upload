class HomeController < ApplicationController
  skip_before_filter :authenticate

  #Home controller exists to display information about the tool. But for now it just redirects to either
  #the reports index page or the user sign in page, depending on authentication being present or not
  def index
    if current_admin || current_user
      redirect_to reports_path
    else
      redirect_to new_user_session_path, :notice => flash[:notice]
    end
  end
end
