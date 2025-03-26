class CategoryValidator < ActiveModel::Validator
  
  def validate(record)
    if record.category?
      raise Error::UnknownCategort unless ["Beginner", "C", "С+", "B", "A"].include?(record.category)
  	end
  end
	
end