# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery

  def only_admin!
    if !current_user.admin?
      flash[:alert] = "Żeby edytować książkę należy mieć uprawnienia administratora."
      redirect_to :back
    end
  end
end
