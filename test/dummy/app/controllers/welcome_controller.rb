class WelcomeController < ApplicationController
  before_filter :authenticate_user!, only: [:index, :logged_in_page]
  
  def index
  end
  
  def logged_in_page
    render text: 'logged in!'
  end
end
