class EmailValidator < ActiveModel::Validator
  
  def validate(record)
    if record.email_changed?
      regexp = /\A[^@\s]+@[^@\s]+\z/
    	raise Error::WrongEmailFormat unless regexp.match?(record.email)  
    	raise Error::EmailExists if User.exists?(email: record.email)
    end
  	
  end
	
end