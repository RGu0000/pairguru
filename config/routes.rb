Rails.application.routes.draw do
  devise_for :users

  root "home#welcome"
  # resources :users do
  #   resources :comments, only: %i[create destroy]
  # end
  resources :genres, only: :index do
    member do
      get "movies"
    end
  end

  resources :movies, only: [:index, :show] do
    member do
      get :send_info
    end

    collection do
      get :export
    end

    resources :comments, only: %i[create destroy]
    resources :likes, only: %i[create destroy]
  end

  post 'movie_id/:movie_id/user_id/:user_id/score/:score', to: 'ratings#rate', as: 'rate_movie'

  get 'top_commenters', to: 'comments#top_commenters'
end
