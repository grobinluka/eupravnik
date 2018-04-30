class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  #before_filter :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  
  #protect the databse, while allowing these fields to be updated.
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: [:name, :lastname, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :account_update, keys: [:email, :password, :password_confirmation, :apartment_building_id]
  end
  
  def must_be_admin
    if current_user.admin == false || current_user.admin == NIL
      redirect_to root_path, alert: "You don't have the rights to be there."
    end
  end
  
  def must_be_superadmin
    if current_user.superadmin == false || current_user.superadmin == NIL
      redirect_to root_path, alert: "You don't have the rights to be there."
    end
  end
  
end
