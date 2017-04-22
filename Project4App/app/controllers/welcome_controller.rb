class WelcomeController < ApplicationController
  def homepage

  end
  #declare global variables
  @supervisor = nil

  #runs when the login button is clicked on the login page
  def login

    #retrieve parameters from html field on login page
    @username = params[:login][:username]
    @password = params[:login][:password]




    #search for the existence of @username and @password
    @loginStatus = ActiveRecord::Base.connection.exec_query %Q{CALL pConfirmLogin('#{@username}','#{@password}')}
    ActiveRecord::Base.clear_active_connections!

    #if valid login store session variables
    if !@loginStatus[0].nil?
      session[:eid] = @loginStatus[0]['eid']
      @supervisor = @loginStatus[0]['supervisor']
      session[:supervisor] = @supervisor
      session[:firstname] = @loginStatus[0]["firstname"]
    end



    #find level of account permissions and redirect to the appropriate view
    if @supervisor == 1
      redirect_to(employees_view_all_emp_url)
    elsif @supervisor == 0
      redirect_to(projects_viewProjects_url)
    else
      render plain: 'Invalid Username or Password'
    end
  end

  #runs when logout is clicked in the nav bar
  def logout
    session.clear
    redirect_to(welcome_homepage_url)
  end



end
