class Error::CustomFailureApp < Devise::FailureApp
  def respond
    if request.format.json?
      # json_error_response
      case failure_reason
      when :invalid_login # Неверный email/пароль
        json_error_response(110, 'Неверный email или пароль')
      when :invalid_token # Неверный токен в заголовке
        json_error_response(150, 'wrong autorization, please login')
      else
        json_error_response(151, 'xz')
      end
    else
      super
    end
  end

  private

  def json_error_response(_code, _message)
    self.status = :ok
    self.content_type = 'application/json'
    self.response_body = { code: _code, message: _message }.to_json
  end

  def failure_reason
    # Проверяем наличие токена в заголовке
    auth_header = request.headers['Authorization']
    if auth_header.present? && auth_header.match(/^Bearer /)
      :invalid_token
    else
      :invalid_login
    end
  end  
end