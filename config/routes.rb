Rails.application.routes.draw do

    resources :themes, param: :slug, except: [:destroy] do
        collection do
            #get ':slug' => 'themes#show'
            get ':slug/destroy' => 'themes#destroy'
        end
        resources :questions, param: :slug, except: [:destroy, :new, :edit, :create, :update] do
            collection do
                #get ':slug' => 'questions#show'
                get ':slug/destroy' => 'questions#destroy'
                post 'search' => 'questions#search'
            end
            resources :articles, except: [:destroy, :new, :edit, :create, :update] do
                collection do
                    get ':id/destroy' => 'articles#destroy'
                end
            end
        end
    end

    get '/' => 'pages#home'

    get '/admin' => 'themes#index'

    get '/questions/new' => 'questions#new'
    get '/questions/:slug/edit' => 'questions#edit'
    post '/questions/create' => 'questions#create'
    patch '/questions/:slug/update' => 'questions#update'
    post '/questions/search' => 'questions#search'

    get '/articles/new' => 'articles#new'
    get '/articles/:id/edit' => 'articles#edit'
    post '/articles/create' => 'articles#create'
    patch '/articles/:id/update' => 'articles#update'

    # The priority is based upon order of creation: first created -> highest priority.
    # See how all your routes lay out with "rake routes".

    # You can have the root of your site routed with "root"
    # root 'welcome#index'

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
