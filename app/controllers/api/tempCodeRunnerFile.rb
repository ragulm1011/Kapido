if current_user.rider?
      render json: {message: "You are not authorized to view this page "} , status: :forbidden
    end
