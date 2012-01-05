# encoding: utf-8
class ProfilesController < ApplicationController

  def index
    @paginate = User.order('id DESC').page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @assigments = Booksassigment.find_all_by_user_id(@user.id)
  end

end
