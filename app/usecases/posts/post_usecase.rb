require_relative '../../forms/posts/post_form.rb'
module Posts
    class PostUsecase < BaseUseCase
        def initialize(params , user = nil)
            @params = params
            @form = Posts::PostForm.new(params)
            @user = user
        end

        def create
            begin
                post_create_service = Posts::PostService.new(@form.attributes,@user)
                if @form.valid?
                    response = post_create_service.create
                    if response[:status] == :created
                        return {post: response[:post], status: :created}
                    end
                    else
                        @post = Post.new(@form.attributes)
                    return {post: @post, errors: @form.errors, status: :unprocessable_entity}
                end
            rescue StandardError => errors
                return {post: @post, errors: errors.message, status: :unprocessable_entity}
            end
        end

        def update(post)
            return {post: post, errors: "Invalid form", status: :unprocessable_entity} unless @form.valid?

            service = Posts::PostService.new(@form.attributes)
            response = service.update(post) 

            response
        rescue StandardError => e
            {post: post, errors: e.message, status: :unprocessable_entity}
        end

        def destroy(deleted_post)
            begin
                post_delete_service = Posts::PostService.new(@params)
                if post_delete_service.destroy(deleted_post)
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