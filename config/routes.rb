Rails.application.routes.draw do
  devise_for :usuarios

  root to: 'home#index'

  namespace :home do
    get 'lista'
  end

  namespace :usuarios do
    get 'asignaciones_seguimiento'
    post 'actualizar_clave'
    post 'agregar_seguimiento'
    post 'quitar_seguimiento'
  end

  namespace :matrimonios do
    get 'lista'
    post 'destroy'
  end

  namespace :actividades do
    get 'matrimonios'
    post 'agregar_quitar_participante'
  end

  namespace :personas do
    get 'lista'
    post 'destroy'
    post 'guardar_seguimiento'
    get 'obtener_nota'
  end

  resources :usuarios
  resources :parametros
  resources :matrimonios
  resources :actividades
  resources :circulo_amistades
  resources :personas do
    resources :personas_nota_seguimiento, except: [:index, :show]
  end
end
