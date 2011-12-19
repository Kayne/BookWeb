class ApplicationController < ActionController::Base
  protect_from_forgery
  require 'will_paginate/array'
end
