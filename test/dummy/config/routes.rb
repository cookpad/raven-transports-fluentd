Rails.application.routes.draw do
  post '/' => 'welcome#index'
  root to: 'welcome#index'

  get '/exception' => 'welcome#exception'
end
