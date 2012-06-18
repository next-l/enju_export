Rails.application.routes.draw do
  resources :export_files, :only => [:index, :show, :destroy]
end
