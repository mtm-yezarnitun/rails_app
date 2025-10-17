module Posts
    class PostForm < BaseForm
        VirtusMixin = Virtus.model
        include VirtusMixin
        include ActiveModel::Validations
        
        attribute :title, String
        attribute :message, String
        attribute :category_id, Integer

        validates :title, presence: { message: "Title cannot be empty." }
        validates :message, presence: { message: "Message cannot be empty." }
        validates :category_id, presence: { message: "Please Select a category." }
    end
end