class Tag < ApplicationRecord
    has_many :taggings
    has_many :tutorials, through: :taggings
end
