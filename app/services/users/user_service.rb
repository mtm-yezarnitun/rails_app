module Users
  class UserService
    def initialize(params)
      @params = params
    end

    def create
      user = User.new(@params)
      if user.save
        return {user: user, status: :created}
      else
        return {user: user, status: :unprocessable_entity}
      end
    end

    def update(user)
      if user.update(@params.except(:id))
        {user: user, status: :updated}
      else
        {user: user, errors: user.errors.full_messages, status: :unprocessable_entity}
      end
    end


    def destroy(deleted_user)
      user = User.find(deleted_user[:id])
      if user.destroy
        return true
      else
        return false
      end
    end
    
  end
end
