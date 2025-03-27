class ApplicationController < ActionController::API
  include Error::ErrorHandler  
  # include ActionController::RequestForgeryProtection
  before_action :configure_permitted_parameters, if: :devise_controller?
  # protect_from_forgery with: :null_session
  
  protected

  def configure_permitted_parameters
    # devise_parameter_sanitizer.permit(:sign_up, keys: %i[name, email])#, surname, gender, category, rating, position, city_id, country_id, club_id, date_of_birth])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])

    devise_parameter_sanitizer.permit(:account_update, keys: %i[name email surname gender category rating position city_id country_id club_id date_of_birth])
  end
end
