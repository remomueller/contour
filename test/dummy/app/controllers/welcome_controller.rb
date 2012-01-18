class WelcomeController < ApplicationController
  before_filter :authenticate_user!, only: [:index, :logged_in_page]
  
  def index
  end
  
  def logged_in_page
    respond_to do |format|
      format.html { render text: 'logged in!' }
      format.json { render json: { name: 'Name', count: 5 } }
    end
  end
end
