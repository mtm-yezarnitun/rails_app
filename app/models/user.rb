class User < ApplicationRecord
    validates :name, presence: true, uniqueness: { case_sensitive: false }, length: {maximum: 50}
    validates :email, presence: true, uniqueness: {case_sensitive: true}, length: {maximum:50}
end
