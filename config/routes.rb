Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
  devise_for :users
  resources :posts do
    resources :comments, only: [:create, :show, :destroy, :edit, :update]
  end

  get '/profile', to: 'users#show', as: 'profile'
  get '/stories', to: 'posts#user_stories', as: 'user_stories'

  root "posts#index"
end
