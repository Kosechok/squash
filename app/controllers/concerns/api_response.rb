module ApiResponse
  def render_success(data, options = {})
    key = options.delete(:key) || infer_key_from_data(data)
    serialized_data = serialize_data(data, options)
    render json: { code: 0, key => serialized_data }
  end

  private

  def serialize_data(data, options = {})
    if data.respond_to?(:to_ary)
      data.map { |item| serialize_item(item, options) }
    else
      serialize_item(data, options)
    end
  end

  def serialize_item(item, options = {})
    if item.respond_to?(:serializable_hash)
      serializer_class = "#{item.class.name}Serializer".constantize
      # Правильный способ передачи параметров для JSONAPI::Serializer
      serializer_class.new(item, params: options).serializable_hash[:data][:attributes]
    else
      item.as_json(options)
    end
  end

  def infer_key_from_data(data)
    if data.respond_to?(:model)
      data.model.name.underscore.pluralize.to_sym
    elsif data.is_a?(ApplicationRecord)
      data.class.name.underscore.to_sym
    else
      :items
    end
  end
end