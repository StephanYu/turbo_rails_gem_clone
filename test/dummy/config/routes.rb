Rails.application.routes.draw do
  resources :articles
  #mount TurboRailsGem::Engine => "/turbo_rails_gem"
end
