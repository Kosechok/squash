class PasswordValidator< ActiveModel::Validator

  def initialize(opt = {})
  	@min_length = opt[:min_length] || 2
  	@max_length = opt[:max_length] || 80
  end
  
  def validate(record)
  	raise Error::NoPassword unless record.password.present?
  	raise Error::PasswordTooShort if record.password.length < @min_length
  	raise Error::PasswordTooLong if record.password.length > @max_length
  end
	
end