Rails.application.routes.draw do
  get 'exchanges', to: 'exchange#list', as: 'exchange_list'
  get 'exchanges/:title', to: 'exchange#show_info', as: 'exchange_show_info'
  get 'exchanges/:title/fetchMarkets', to: 'exchange#markets', as: 'markets'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
