# module Error
#   module ErrorHandler
#     def self.included(clazz)
#       clazz.class_eval do
#         rescue_from ActiveRecord::RecordNotFound do |e|
#           respond(404, e.to_s)
#         end

#         rescue_from StandardError do |e|
#           respond(500, e.to_s)
#         end

#         rescue_from CustomError do |e|
#           respond(e.error,
#             e.message.to_s,
#             e.addition)
#         end

#         # rescue_from Mongoid::Errors::DocumentNotFound do
#         #   respond(22, I18n.t('error.nothing_found'), nil)
#         #   # raise Error::NothingFound
#         # end

#         # rescue_from CustomException do |e|
#         #   # respond(e.error,
#         #   #   e.message.to_s)
#         #   puts "====================Sdfdsfdsfsdf sdf sdf"
#         # end
#         # rescue_from ActionController do |e|
#         #   respond(60, "No such route")
#         # end

#       end
#     end

#     private

#     def respond(_error, _message, _addition)
#     # def respond(*args)
#     #   puts "---------"
#     #   puts args.inspect
#     #   puts "_________________________________"
#       json = Helpers::Render.json(_error,
#         # _status,
#         _message,
#         _addition)
#       render json: json#, status: _status
#     end
#   end
# end
module Error
  module ErrorHandler
    def self.included(clazz)
      clazz.class_eval do
        # rescue_from ActiveRecord::RecordNotFound do |e|
        #   respond(:record_not_found, e.to_s, 200)
        # end
        rescue_from CustomError do |e|
          respond(e.code, e.message.to_s)
        end
        # rescue_from StandardError do |e|
        #   respond(:standard_error, 500, e.to_s)
        # end

        # rescue_from JWT::DecodeError do |e|
        #   respond(200, 'Неверный email или пароль')
        # end
        # rescue_from JWT::VerificationError do |e|
        #   respond(200, 'Неверный email или пароль')
        # end
        # rescue_from JWT::ExpiredSignature do |e|
        #   respond(200, 'Неверный email или пароль')
        # end        
      end
    end

    private

    # def respond(_error, _status, _message)
    #   json = Helpers::Render.json(_code, _message)
    #   render json: json#, status: _status
    # end
    def respond(_code, _message)
      json = Helpers::Render.json(_code, _message)
      render json: json#, status: _status
    end    
  end
end