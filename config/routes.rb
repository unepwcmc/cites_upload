CitesUpload::Application.routes.draw do
  get "home/index"

  devise_for :admins

  devise_for :users

  mount Tolk::Engine => "/tolk"
  scope "(:locale)", :locale => /en|fr|es/ do
    resources :reports
    resources :users do
      member do
        put :approve
        put :disapprove
        get :has_report
      end
    end
    resources :admins
  end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
