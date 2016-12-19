class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:dashboard]
  def home
    if current_user
      redirect_to dashboard_path
    end
  end

  def dashboard
    @user = current_user
    @reviews = current_user.reviews
    @places = current_user.places
  end
end
