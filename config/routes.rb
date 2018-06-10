Rails.application.routes.draw do
  get '/', to: 'search#index'
  get '/institutions', to: 'api#all_institutions'
  get '/institutions/:id', to: 'api#institution'
  get '/plan-all/:time', to: 'api#plan_all'
  get '/plan-single/:id/:time', to: 'api#plan_single'
  get '/peak-hours/:id', to: 'api#peak_hours'

  post '/study', to: 'api#set_study_room'
end
