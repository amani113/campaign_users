Rails.application.routes.draw do
  resources :users, only: %i[create index] do
    collection do
      get 'filter'
    end
  end
end
