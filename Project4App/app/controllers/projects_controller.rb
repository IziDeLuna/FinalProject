class ProjectsController < ApplicationController

  def viewProjects
     @empfirstname = 'Carlos'
     @currentProject = 'Finance Review'
     @location = 'Main Office'
     @supervisor = 'John Doe'
     @eid = session[:eid]

     @results = ActiveRecord::Base.connection.exec_query %Q{CALL pGetEmployeeProjects(#@eid)}
     ActiveRecord::Base.clear_active_connections!

     jsonObject = @results.as_json

    @currentProject = jsonObject[0]["pname"]
    @location = jsonObject[0]["location"]





  end
end
