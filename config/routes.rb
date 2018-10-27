Rails.application.routes.draw do
  get 'tickets/:id'
  post 'tickets/create'
  post 'tickets/check'
  put 'tickets/confirm'
end
