class WelcomeController < ApplicationController
  def homepage
  end
  @eid = nil
  @supervisor = nil
  def login


    @username = params[:login][:username]
    @password = params[:login][:password]




    #search for the existance of @username and @password
    @loginStatus = ActiveRecord::Base.connection.exec_query %Q{CALL pConfirmLogin('#{@username}','#{@password}')}
    ActiveRecord::Base.clear_active_connections!

    if !@loginStatus[0].nil?
      @eid = @loginStatus[0]['eid']
      @supervisor = @loginStatus[0]['supervisor']
      session[:eid] = @eid
      session[:supervisor] = @supervisor
    end



    #find level of account permissions and redirect to the appropriate view
    if @supervisor == 1
      redirect_to(projects_viewProjects_url)
    elsif @supervisor == 0
      redirect_to(projects_viewProjects_url)
    else
      render plain: 'Invalid Username or Password'
    end
  end

  def logout
    session.clear
    redirect_to(welcome_homepage_url)
  end



end
