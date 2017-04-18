class ProjectsController < ApplicationController

  def viewProjects
    #setting defualt variables for page
     @empfirstname = session[:firstname]
     @currentProject = 'No Current Project'
     @location = 'No Current Office'
     @firstsups = 'No Current Supervisor'
     @pid = -1
     @eid = session[:eid]

    #Retrieve and parse the current project
     @firstProject = ActiveRecord::Base.connection.exec_query %Q{CALL pGetCurrentProject(#@eid)}
     ActiveRecord::Base.clear_active_connections!
     @jsonObject = @firstProject.as_json
     if !@jsonObject[0].nil?

       @currentProject = @jsonObject[0]["pname"]
       @location = @jsonObject[0]["location"]
       @pid = @jsonObject[0]["pid"]

      firstProjectSups = ActiveRecord::Base.connection.exec_query %Q{CALL pGetProjectSupervisors(#@pid)}
      ActiveRecord::Base.clear_active_connections!
       j =0
       @firstsups = String.new
       firstProjectSups = firstProjectSups.as_json
       while j < firstProjectSups.length do
         @firstsups += firstProjectSups[j]["firstname"] +" "+
             firstProjectSups[j]["lastname"] + ", "
         j += 1
       end
     end


     @results = ActiveRecord::Base.connection.exec_query %Q{CALL pGetEmployeeProjects(#@eid)}
     ActiveRecord::Base.clear_active_connections!


     @employeeProjects = @results.as_json
     @counter = @employeeProjects.length


     @supers = Array.new


     i=0
    while i < @counter
      @tempString = String.new
      @temp = @employeeProjects[i]["pid"]
      @supers[i] = ActiveRecord::Base.connection.exec_query %Q{CALL pGetProjectSupervisors(#@temp)}
      ActiveRecord::Base.clear_active_connections!
      @supers[i] = @supers[i].as_json
      j = 0
      while j < @supers[i].length do
         @tempString += @supers[i][j]["firstname"] +" "+ @supers[i][j]["lastname"] + ", "
        j += 1
      end
      @employeeProjects[i]["sups"] = @tempString
      i+=1
    end

  end
end
