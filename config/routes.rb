ActionController::Routing::Routes.draw do |map|

  map.connect  'assignments/:id/assign', :controller => 'assignments', :action => 'assign'
  map.resources :assignments

  map.connect 'projects/:pnum/guest/:pgid', :controller => 'projects', :action => 'showguest'
  map.resources :projects
  map.root :controller => 'home', :index => 'index'
  map.about '/about', :controller => 'home', :action => 'about'
  map.about '/faq', :controller => 'home', :action => 'faq'
  map.about '/germanfaq', :controller => 'home', :action => 'germanfaq'
  map.about '/helpreport', :controller => 'home', :action => 'helpreport'
  map.about '/helpentry', :controller => 'home', :action => 'helpentry'
  map.about '/helpproject', :controller => 'home', :action => 'helpproject'
  
  map.resources :entries, :collection => { :show_all => :post, :incomplete => :post, :last_ten => :post },:member => { :stop => :put }
  
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.login_with_openid '/login_with_openid', :controller => 'openid_sessions', :action => 'new'
  map.signup '/signup', :controller => 'user/profiles', :action => 'new'
  map.beta_signup '/signup/:invitation_token', :controller => 'user/profiles', :action => 'new'
	map.openid_signup '/openid_signup', :controller => 'openid_sessions', :action => 'index'
	map.beta_openid_signup '/openid_signup/:invitation_token', :controller => 'openid_sessions', :action => 'index'
	map.activate '/activate/:activation_code', :controller => 'user/activations', :action => 'activate', :activation_code => nil
  map.forgot_password '/forgot_password', :controller => 'user/passwords', :action => 'new'  
	map.reset_password '/reset_password/:id', :controller => 'user/passwords', :action => 'edit', :id => nil  
	map.resend_activation '/resend_activation', :controller => 'user/activations', :action => 'new'
  map.namespace :admin do |admin|
		admin.resources :controls
		admin.resources :invite_actions
		admin.resources :invites
		admin.resources :mailings
		admin.resources :states
    admin.resources :users do |users|
			users.resources :roles
		end    
  end

  map.namespace :user do |user|
		user.resources :activations
		user.resources :invitations
		user.resources :openid_accounts 
		user.resources :passwords
    user.resources :profiles do |profiles|
			profiles.resources :password_settings
		end
  end
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  
  map.resources :users
  map.resource :session
  
  # See how all your routes lay out with "rake routes"


	map.resource  :session
	map.resource  :openid_session
	map.resources :members
  map.connect '/report/:project/:month', :controller => 'report', :action => 'show'
  map.connect '/report', :controller => 'report', :action => 'index'
  map.connect '/colleagues', :controller => 'colleagues', :action => 'index'
	map.logged_exceptions "logged_exceptions/:action/:id", :controller => "logged_exceptions"

  # Install the default routes as the lowest priority.
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
	map.connect '*path' , :controller => 'four_oh_fours'
end
