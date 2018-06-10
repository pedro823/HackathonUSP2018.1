Rails.application.routes.draw do
  get '/', to: 'search#index'
  get '/institutions', to: 'api#all_institutions'
  get '/institutions/:id', to: 'api#institution'
end
