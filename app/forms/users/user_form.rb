module Users
    class UserForm < BaseForm
        VirtusMixin = Virtus.model
        include VirtusMixin
        include ActiveModel::Validations
        
        attribute :name, String
        attribute :email, String
        attribute :info, String
        attribute :encrypted_password, String


        validates :name, presence: { message: "Name cannot be empty." }
        validates :email, presence: { message: "Email cannot be empty." }
        validates :info, presence: { message: "Info cannot be empty." }
        validates :encrypted_password, presence: { message: "Password cannot be empty." }
    end
end