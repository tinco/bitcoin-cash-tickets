Rails.application.routes.draw do
  get 'api/tickets/:id', to: 'tickets#show'
  post 'api/tickets/create', to: 'tickets#create'
  post 'api/tickets/check', to: 'tickets#check'
  put 'api/tickets/confirm', to: 'tickets#confirm'
end
