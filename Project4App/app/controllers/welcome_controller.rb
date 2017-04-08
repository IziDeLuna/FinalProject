class WelcomeController < ApplicationController
  def homepage
  end

  def login

    @username = params[:login][:username]
    @password = params[:login][:password]
    render plain: @username + " " +  @password
    #search for the existance of @username and @password


    #find level of account permissions and redirect to the appropriate view

  end
end
