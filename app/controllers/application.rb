# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  layout "application"
  # AuthenticatedSystem must be included for RoleRequirement, and is provided by installing acts_as_authenticates and running 'script/generate authenticated account user'.
  include AuthenticatedSystem
  # You can move this into a different controller, if you wish.  This module gives you the require_role helpers, and others.
  include RoleRequirementSystem
	include ExceptionLoggable
	before_filter :set_current_user
	before_filter :adjust_format_for_iphone
  before_filter :iphone_login_required

  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery 
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  filter_parameter_logging :password, :password_confirmation, :old_password

  # Change to the location of your contact form
	def contact_site
		root_path
	end

	def nested_layout
		"default"
	end

	def in_beta?
		APP_CONFIG['settings']['in_beta']
	end
  protected
    def set_current_user
      User.current_user = self.current_user
    end
    
  private

    # Set iPhone format if request to iphone.trawlr.com
    def adjust_format_for_iphone
      request.format = :iphone if iphone_request?
    end

    # Force all iPhone users to login
    def iphone_login_required
      if iphone_request?
        redirect_to login_path unless logged_in?
      end
    end

    # Return true for requests to iphone.trawlr.com
    def iphone_request?
      return (request.subdomains.first == "iphone" || params[:format] == "iphone")
    end

  
end
