# encoding: utf-8
class ProfilesController < ApplicationController

  def index
    @users = User.all(:order => 'id DESC', :limit => 30);
  end

  def show
    @user = User.find_by_id(params[:id])
    @assigments = Booksassigment.find_all_by_user_id(params[:id])
  end

end
