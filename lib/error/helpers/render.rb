# module Error::Helpers
#   class Render
#     def self.json(_error = 0,
#      # _status,
#       _message = "", _addition = nil)
#       {
#         # status: _status,
#         code: _error,
#         message: _message,
#         addition_data: _addition
#       }.compact.as_json
#     end
#   end
# end
module Error::Helpers
  class Render
    def self.json(_code, _message)
      {
        code: _code,
        message: _message
      }.as_json
    end
  end
end