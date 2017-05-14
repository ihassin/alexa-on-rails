Rails.application.routes.draw do
  # Amazon comes in with a post request
  # resource :skills, only: [:create]
  post '/' => 'skills#root', :as => :root
end
