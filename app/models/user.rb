class User < ApplicationRecord
    has_many :posts, dependent: :destroy

    validates :name, presence: true, uniqueness: { case_sensitive: false }, length: {maximum: 50}
    validates :email, presence: true, uniqueness: {case_sensitive: true}, length: {maximum:50}
end
