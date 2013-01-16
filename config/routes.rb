Configvm::Application.routes.draw do
  resources :hypervisors

  resources :shorewallpolicies

  resources :hosts

  resources :shorewallrules

  resources :vms

  resources :interfaces

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)
	
	match 'login' => 'users#login'
	match 'logout' => 'users#logout'
	match 'verifyLogin' => 'users#verifyLogin'

	match 'hypervisorspost' => 'hypervisors#post'

	match 'nuevaInt/:host_id' => 'interfaces#newInterface'

	match 'cambiarEstado/:vm_id' => 'vms#changeStatus'
	match 'nuevaVm/:hypervisor_id' => 'vms#newVm'

	match 'nuevoHypervisor/:host_id' => 'hypervisors#newHypervisor'
	
	match 'shorewall_rules/:host_name' => 'hosts#getShorewallRulesFile'   
	match 'shorewall_policy/:host_name' => 'hosts#getShorewallPolicyFile'
	match 'shorewall_zones/:host_name' => 'hosts#getShorewallZonesFile'
	match 'shorewall_interfaces/:host_name' => 'hosts#getShorewallInterfacesFile'

	match 'nuevaReglaShorewall/:host_id' => 'shorewallrules#newShorewallrule'

	match 'nuevaPolicyShorewall/:host_id' => 'shorewallpolicies#newShorewallpolicy'



	#in rails 2
  #map.login 'login', :controller => 'users', :action => 'login'
  #map.logout 'logout', :controller => 'users', :action => 'logout'

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

 
 # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"
   root :to => "users#home"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
   match ':controller(/:action(/:id(.:format)))'



end
