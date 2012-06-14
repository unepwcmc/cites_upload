class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale
  before_filter :authenticate

  private
  def set_locale
    I18n.locale = params[:locale]
  end

  def default_url_options(options={})
    options.merge({:locale => I18n.locale})
  end

  def authenticate
    if !current_user && !current_admin
      authenticate_user!
    end
  end
end
