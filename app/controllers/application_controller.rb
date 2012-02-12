# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery

  after_filter :user_activity

  def only_admin!
    if !current_user.admin?
      flash[:alert] = "Żeby edytować książkę należy mieć uprawnienia administratora."
      redirect_to :back
    end
  end

  def user_activity
    current_user.try :touch
  end
end
