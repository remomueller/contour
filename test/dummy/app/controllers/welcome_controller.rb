# Show a public welcome page and a non-public page
class WelcomeController < ApplicationController
  before_action :authenticate_user!, only: [:index, :logged_in_page]

  def index
  end

  def logged_in_page
    respond_to do |format|
      format.html { render plain: 'logged in!' }
      format.json { render json: { name: 'Name', count: 5 } }
    end
  end
end
