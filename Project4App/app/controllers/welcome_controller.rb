class WelcomeController < ApplicationController
  def homepage
  end

  def login
    render plain: params[:login].inspect
  end
end
