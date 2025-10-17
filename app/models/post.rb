class Post < ApplicationRecord
    belongs_to :category
    belongs_to :user

    validates :title, :message, :category_id, presence: true
end
