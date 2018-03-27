Rails.application.routes.draw do
  devise_for :usuarios

  root to: 'home#index'

  namespace :home do
    get 'lista'
  end

  namespace :usuarios do
    post 'actualizar_clave'
    post 'agregar_seguimiento'
    post 'quitar_seguimiento'
  end

  namespace :matrimonios do
    get 'lista'
    post 'destroy'
    post 'guardar_seguimiento'
    get 'obtener_nota'
  end

  namespace :actividades do
    get 'matrimonios'
    post 'agregar_quitar_participante'
  end

  resources :usuarios
  resources :parametros
  resources :matrimonios
  resources :actividades
  resources :circulo_amistades
end
