Rails.application.routes.draw do
  resources :detallepedidos

  resources :admin

  resources :categoriaentidades,:path => "categorias",:path_names => {new: 'nuevo',"edit"=>'editar'}

  resources :pedidos do
    collection do
      get 'confirmacion'
      get 'listar-:tipo', action: :listar
    end

    member do
      post 'cambiar-estado', action: :cambiar_estado
    end
  end

  resources :productos

  resources :entidades,:path => :restaurantes

  resources :usuarios do
    collection do
      post 'recordar-clave',:action=>'recordar_clave'
      get 'recordar-clave',:action=>'recordar_clave'
      post 'enviar_sms'
      post 'autenticar'
      get 'login'
      post 'login'
      get 'salir'
      post 'existe-usuario', :action => 'existe_usuario'
    end
  end

  resources :yo do
    collection do
      get 'mis-pedidos', action: :mis_pedidos
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'default#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
