require_relative '../../forms/users/user_form.rb'
module Users
    class UserUsecase < BaseUseCase
        def initialize(params)
            @params = params
            @form = Users::UserForm.new(params)
        end

        def create
            begin
                user_create_service = Users::UserService.new(@form.attributes)
                if @form.valid?
                    response = user_create_service.create
                    if response[:status] == :created
                        return {user: response[:user], status: :created}
                    end
                    else
                        @user = User.new(@form.attributes)
                    return {user: @user, errors: @form.errors, status: :unprocessable_entity}
                end
            rescue StandardError => errors
                return {user: @user, errors: errors.message, status: :unprocessable_entity}
            end
        end

        def update(updated_user)
            begin
                user_update_service = Users::UserService.new(@params)
                response = user_update_service.update(updated_user)
                if @form.valid?
                    response = user_update_service.update
                    if response[:status] == :updated
                        return {user: response[:user], status: :updated}
                    end
                    else
                        @user = User.new(@form.attributes)
                    return {user: @user, errors: @form.errors, status: :unprocessable_entity}
                end
            rescue StandardError => errors
                return {user: @user, errors: errors.message, status: :unprocessable_entity}
            end
        end

        def destroy(deleted_user)
            begin
                user_delete_service = Users::UserService.new(@params)
                if user_delete_service.destroy(deleted_user)
                    return true
                else
                    return false
                end
            rescue StandardError => errors
                return false
            end
        end
    end
end