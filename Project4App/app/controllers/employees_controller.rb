class EmployeesController < ApplicationController
  def index

  end

  def new

  end

  def create
    #render plain: params[:post].inspect
    @username = params[:add_emp][:username]
    @password = params[:add_emp][:password]
    @firstname = params[:add_emp][:firstname]
    @lastname = params[:add_emp][:lastname]
    @sup = params[:add_emp][:supervisor]

    @addemp = ActiveRecord::Base.connection.exec_query %Q{CALL eInsertIntoEmp('#{@username}','#{@password}','#{@firstname}','#{@lastname}','#{@sup}')}
    ActiveRecord::Base.clear_active_connections!

    redirect_to(employees_view_all_emp_url)

  end
  def delete_pro

    @pid = params["format"]
    @tmp = @pid

    @pid = ActiveRecord::Base.connection.exec_query %Q{CALL pDeletePro('#{@pid}')}
    ActiveRecord::Base.clear_active_connections!

    @tmp = ActiveRecord::Base.connection.exec_query %Q{CALL pDeleteProEmp('#{@tmp}')}
    ActiveRecord::Base.clear_active_connections!


    redirect_to(employees_view_all_pro_url)

  end
  def delete_emp
    @eid = params["format"]
    @tmp = @eid

    @eid = ActiveRecord::Base.connection.exec_query %Q{CALL eDeleteEmp('#{@eid}')}
    ActiveRecord::Base.clear_active_connections!

    @tmp = ActiveRecord::Base.connection.exec_query %Q{CALL eDeleteEmpPro('#{@tmp}')}
    ActiveRecord::Base.clear_active_connections!

    redirect_to(employees_view_all_emp_url)
  end
  def add_pro_new

  end
  def add_pro_create

    @pname = params[:add_pro][:pname]
    @start_date = params[:add_pro][:start_date]
    @end_date = params[:add_pro][:end_date]
    @location = params[:add_pro][:location]

    @addpro = ActiveRecord::Base.connection.exec_query %Q{CALL pInsertIntoPro('#{@pname}','#{@start_date}','#{@end_date}','#{@location}')}
    ActiveRecord::Base.clear_active_connections!

    redirect_to(employees_view_all_pro_url)


  end
  def view_all_emp

    @allEmp = ActiveRecord::Base.connection.exec_query %Q{CALL eGetAllEmp()}
    ActiveRecord::Base.clear_active_connections!

    @allEmpJson = @allEmp.as_json

    @counter = @allEmpJson.length



  end

  def view_all_pro

    @allPro = ActiveRecord::Base.connection.exec_query %Q{CALL pGetAllPro()}
    ActiveRecord::Base.clear_active_connections!

    @allProJson = @allPro.as_json

    @count = @allProJson.length
  end

  def view_all_act_pro
    #setting defualt variables for page
    @pp = -1

    #Retrieve and parse the current project
    @allProject = ActiveRecord::Base.connection.exec_query %Q{CALL pGetAllPro()}
    ActiveRecord::Base.clear_active_connections!

    #convert ActiveRecord object to json
    @jsonObject = @allProject.as_json
    i = 0
    @sup = String.new
    @supArray = Array.new
    @ProjectSups = Array.new
    @ProjectEmps = Array.new
    @counter = @jsonObject.length
    @supp = []

    while i < @jsonObject.length do
      @pp = @jsonObject[i]["pid"]
      @ProjectSups[i] = ActiveRecord::Base.connection.exec_query %Q{CALL pGetProjectSupervisors('#{@pp}')}
      ActiveRecord::Base.clear_active_connections!
      j = 0
      @supArray[i] = @ProjectSups[i].as_json
      while j < @supArray[i].length do
        @sup += @supArray[i][j]["firstname"] +" "+
            @supArray[i][j]["lastname"] + ", "
        j += 1
      end
      @supp[i] = @sup

      @ProjectEmps[i] = ActiveRecord::Base.connection.exec_query %Q{CALL pGetProjectEmps('{#@pp}')}
      ActiveRecord::Base.clear_active_connections!
      @ProjectEmps[i] = @ProjectEmps[i].as_json
      i += 1
    end
  end

end