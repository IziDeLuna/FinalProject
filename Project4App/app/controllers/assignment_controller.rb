=begin

class AssignmentController < ApplicationController

    def view_all_act_pro
      #setting defualt variables for page
      @empfirstname = 'No Current Project'
      @emplastname = 'No Current Project'
      @currentProject = 'No Current Project'
      @location = 'No Current Office'
      @firstsups = 'No Current Supervisor'
      @pid = -1

      #Retrieve and parse the current project
      @firstProject = ActiveRecord::Base.connection.exec_query %Q{CALL pGetCurrentProject(#@eid)}
      ActiveRecord::Base.clear_active_connections!

      #convert ActiveRecord object to json
      @jsonObject = @firstProject.as_json

      #if json object is not empty
      if !@jsonObject[0].nil?
        @currentProject = @jsonObject[0]["pname"]
        @location = @jsonObject[0]["location"]
        @pid = @jsonObject[0]["pid"]

        #find supervisors for the first project
        firstProjectSups = ActiveRecord::Base.connection.exec_query %Q{CALL pGetProjectSupervisors(#@pid)}
        ActiveRecord::Base.clear_active_connections!

        #itterate through and parse all the supervisors into one string
        j =0
        @firstsups = String.new
        firstProjectSups = firstProjectSups.as_json
        while j < firstProjectSups.length do
          @firstsups += firstProjectSups[j]["firstname"] +" "+
              firstProjectSups[j]["lastname"] + ", "
          j += 1
        end
      end

      #Get all past/current/future projects for the currently logged in employee
      @results = ActiveRecord::Base.connection.exec_query %Q{CALL pGetEmployeeProjects(#@eid)}
      ActiveRecord::Base.clear_active_connections!

      #conver ActiveRecord object to json
      @employeeProjects = @results.as_json

      #set counter with length of employee projects
      @counter = @employeeProjects.length

      #declare new array for supervisors
      @supers = Array.new

      #iterate through and retrieve al the supervisors for ALL employee projects
      i=0
      while i < @counter
        @tempString = String.new
        @temp = @employeeProjects[i]["pid"]
        @supers[i] = ActiveRecord::Base.connection.exec_query %Q{CALL pGetProjectSupervisors(#@temp)}
        ActiveRecord::Base.clear_active_connections!
        @supers[i] = @supers[i].as_json
        j = 0
        #Parse them as a single string then store them in an array of strings
        while j < @supers[i].length do
          @tempString += @supers[i][j]["firstname"] +" "+ @supers[i][j]["lastname"] + ", "
          j += 1
        end
        @employeeProjects[i]["sups"] = @tempString
        i+=1
      end

      #iterate through and retrieve all the employees for the active employee projects
      k = 0
      @counter2 = @employeeProjects.length
      #Array for employees to be populated
      @emplArr = Array.new
      while k < @counter2
        @tempString = String.new
        @temp = @employeeProjects[k]["pid"]
        @emplArr[k] = ActiveRecord::Base.connection.exec_query %Q{CALL pGetProjectActiveEmployees(#@temp)}
        ActiveRecord::Base.clear_active_connections!
        @emplArr[k] = @emplArr[k].as_json
        m = 0
        while m < @emplArr[k].length do
          @tempString += @emplArr[k][m]["firstname"] +" "+ @emplArr[k][m]["lastname"] + ", "
          m += 1
        end
        @employeeProjects[k]["emps"] = @tempString
        k += 1
      end

    end

  end
=end
