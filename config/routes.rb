# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

RedmineApp::Application.routes.draw do

	match 'logrobots/index', :controller => 'logrobots', :action => 'index', :via => :get
	match 'logrobots/start', :controller => 'logrobots', :action => 'start', :via => :get
end
