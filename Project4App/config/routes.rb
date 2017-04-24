Rails.application.routes.draw do
  get 'welcome/homepage'
  get post 'welcome/login'
  get 'projects/viewProjects'
  get 'welcome/logout'
  get 'employees/view_all_emp'
  get 'employees/view_all_act_pro'
  get 'employees/view_all_pro'
  get 'employees/add_pro_new'
  get 'projects/assign_project'
  get post 'employees/add_pro_create'
  post 'employees/delete_pro'
  post 'employees/delete_emp'

  root 'welcome#homepage'

  resource :employees

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end



  
  
  
  
  
  
  
  
  
  
  
  
  
  