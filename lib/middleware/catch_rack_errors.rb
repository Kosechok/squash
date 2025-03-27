module Middleware
  class CatchRackErrors

    def initialize(app)
      @app = app
    end         # def initialize


    def call(env)

      begin

        @app.call(env)

      rescue JWT::DecodeError => e

        return [
          200, 
          { "Content-Type" => "application/json" },
          [ 
            { 
              message: 'JWT token is invalid or expired',
              code: '150'
            }.to_json 
          ]
        ]

      end       # rescue

    end         # def call

  end           # class
end             # module