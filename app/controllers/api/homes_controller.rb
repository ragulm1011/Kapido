class Api::HomesController < Api::ApiController
    
    def index 
        msg = "Welcome To Kapido , India's Fastest Taxi Service"
        render json: { message: msg } , status: :ok
    end
end