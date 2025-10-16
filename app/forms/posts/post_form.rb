module Posts
    class PostForm < BaseForm
        VirtusMixin = Virtus.model
        include VirtusMixin
        include ActiveModel::Validations
        
        attribute :title, String
        attribute :message, String

        validates :title, presence: { message: "Title cannot be empty." }
        validates :message, presence: { message: "Message cannot be empty." }
    end
end