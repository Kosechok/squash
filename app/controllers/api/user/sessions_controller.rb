# frozen_string_literal: true

class Api::User::SessionsController < Devise::SessionsController
  # include Error::ErrorHandler 
  respond_to :json
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  def destroy
    signed_out = sign_out(current_user)

    if signed_out
      # Возвращаем успешный JSON-ответ
      render json: { code: 0, message: 'Вы успешно вышли' }, status: :ok
    else
      # Возвращаем ошибку, если выход не удался
      render json: { code: 150, message: 'Ошибка при выходе' }, status: :unprocessable_entity
    end
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  private

  def respond_with(resource, _opt = {})

    @token = request.env['warden-jwt_auth.token']
    headers['Authorization'] = @token

    render json: {
      code: 0,
      token: @token,
      email: resource.email
    }, status: :ok
  end

  def respond_to_on_destroy
    if request.headers['Authorization'].present?
      jwt_payload = JWT.decode(request.headers['Authorization'].split.last,
                               Rails.application.credentials.devise_jwt_secret_key!).first

      current_user = User.find(jwt_payload['sub'])
    end

    if current_user
      render json: {
        status: 200,
        message: 'Logged out successfully.'
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end

  # def respond_to_on_destroy
  #   # Пустой метод, т.к. мы полностью контролируем ответ в destroy
  # end  
end
