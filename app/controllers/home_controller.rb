class HomeController < ApplicationController
  def index
    redirect_to root_url if user_signed_in?
  end
end
