class HomeController < ApplicationController
  skip_before_filter :authenticate

  def index
    if current_admin || current_user
      redirect_to reports_path
    else
      redirect_to new_user_session_path, :notice => flash[:notice]
    end
  end
end
