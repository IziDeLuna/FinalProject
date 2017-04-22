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
  def view_all_emp

    @allEmp = ActiveRecord::Base.connection.exec_query %Q{CALL eGetAllEmp()}
    ActiveRecord::Base.clear_active_connections!

    @allEmpJson = @allEmp.as_json

    @counter = @allEmpJson.length



  end
end
