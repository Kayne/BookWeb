# encoding: utf-8
class ProfilesController < ApplicationController

  def index
    @paginate = User.order('id DESC').page(params[:page])
    id = 0
    id = current_user.id if user_signed_in?
    @onlines = User.online_list(id)
  end

  def show
    @user = User.find(params[:id])
    @assigments = Booksassigment.order('created_at').find_all_by_user_id(@user.id)
    @opinions = Opinion.where(:user_id => @user.id).order('created_at DESC')
  end

  def opinions
    @opinions = Opinion.where(:user_id => params[:id]).includes(:book)
    render(:layout => false)
  end

end
