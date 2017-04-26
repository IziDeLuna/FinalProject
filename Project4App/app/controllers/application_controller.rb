class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def assign_project
    #For displaying the available employees
    @allEmp = ActiveRecord::Base.connection.exec_query %Q{CALL eGetAllEmp()}
    ActiveRecord::Base.clear_active_connections!

    @allEmpJson = @allEmp.as_json

    @counter = @allEmpJson.length

    @allPro = ActiveRecord::Base.connection.exec_query %Q{CALL pGetAllPro()}
    ActiveRecord::Base.clear_active_connections!

    @allProJson = @allPro.as_json

    @countp = @allProJson.length
  end
end

