module Error
  class CustomError < StandardError
    attr_reader :status, :code, :message

    def initialize(_code = nil, _message = nil)#, _status = nil)
      @code = _code || 422
      # @status = _status || :unprocessable_entity
      @message = _message || 'Something went wrong'
    end

    def fetch_json
      Helpers::Render.json(code, message)#, status)
    end
  end
######### Authorizations Errors #########

 
  class EmailExists < CustomError
    def initialize
      super( 100, 'e-mail is busy')
    end
  end

  class PasswordTooShort < CustomError
    def initialize
      super( 101, 'password too short, minimun is 2')
    end
  end

  class PasswordTooLong < CustomError
    def initialize
      super( 102, 'password too long, maximum is 80')
    end
  end  

  class NoPassword < CustomError
    def initialize
      super( 103, 'please provide a password')
    end
  end   

  class WrongEmailFormat < CustomError
    def initialize
      super( 104, 'please provide email in correct format')
    end
  end 

  class UnknownCategort < CustomError
    def initialize
      super( 105, 'unkown category')
    end
  end 

    class NotAutorizes < CustomError
    def initialize
      super( 150, 'wrong autorization, please login')
    end
  end 
  # code 110 reserved in Error::CustomFailureApp for wrong login/pass

end
