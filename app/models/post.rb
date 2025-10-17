class Post < ApplicationRecord
    belongs_to :category

    validates :title, :message, :category_id, presence: true
end
