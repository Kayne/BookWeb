class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_locale
  def set_locale
    I18n.locale = "pl"
  end
end
