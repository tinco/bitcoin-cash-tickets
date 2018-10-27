Rails.application.routes.draw do
  get 'tickets/:id', to: 'tickets#show'
  post 'tickets/create'
  post 'tickets/check'
  put 'tickets/confirm'
end
