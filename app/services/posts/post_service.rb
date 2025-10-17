module Posts
  class PostService
    def initialize(params , user)
      @params = params
      @user = user
    end

    def create
      post = Post.new(@params)
      post.user = @user
      if post.save
        return {post: post, status: :created}
      else
        return {post: post, status: :unprocessable_entity}
      end
    end

    def update(post)
      if post.update(@params.except(:id))
        return {post: post, status: :updated}
      else
        return {post: post, errors: post.errors.full_messages, status: :unprocessable_entity}
      end
    end

    def destroy(deleted_post)
      post = Post.find(deleted_post[:id])
      if post.destroy
        return true
      else
        return false
      end
    end
  end
end
