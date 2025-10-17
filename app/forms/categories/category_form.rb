module Categories
    class CategoryForm < BaseForm
        VirtusMixin = Virtus.model
        include VirtusMixin
        include ActiveModel::Validations
        
        attribute :name, String

        validates :name, presence: { message: "Name cannot be empty." }
    end
end