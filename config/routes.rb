Rails.application.routes.draw do
  devise_for :usuarios

  root to: 'home#index'

  namespace :usuarios do
    post 'actualizar_clave'
  end

  resources :usuarios

  resources :parametros

  namespace :matrimonios do
    get 'lista'
    post 'destroy'
    post 'guardar_seguimiento'
    get 'obtener_nota'
  end

  resources :matrimonios


  namespace :actividades do
    get 'matrimonios'
    post 'agregar_quitar_participante'
  end

  resources :actividades

  resources :circulo_amistades

end
