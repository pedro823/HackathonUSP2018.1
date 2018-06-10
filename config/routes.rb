Rails.application.routes.draw do
  get '/', to: 'search#index'
  get '/institutions', to: 'api#all_institutions'
  get '/institutions/:id', to: 'api#institution'
  get '/plan-study/:time', to: 'api#plan_study'
  post '/study', to: 'api#set_study_room'
end
