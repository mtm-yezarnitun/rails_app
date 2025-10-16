module Posts
  class PostService
    def initialize(params)
      @params = params
    end

    def create
      post = Post.new(@params)
      if post.save
        return {post: post, status: :created}
      else
        return {post: post, status: :unprocessable_entity}
      end
    end

    def update(post)
      if post.update(@params.except(:id))
        {post: post, status: :updated}
      else
        {post: post, errors: post.errors.full_messages, status: :unprocessable_entity}
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
