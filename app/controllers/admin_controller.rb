class AdminController < ApplicationController
  before_filter {
  	redirect_to "/" if not @es_admin 
  }
  def index
  end
end
