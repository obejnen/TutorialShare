class Tutorial < ApplicationRecord
    mount_uploader :image, ImageUploader
    has_many :taggings, dependent: :destroy
    has_many :tags, through: :taggings

    # has_many :commenting
    # has_many :comments, through: :commenting

    has_many :comments, as: :commentable
    belongs_to :category
    belongs_to :user
    validates :title, :description, :body, presence: true

    def all_tags
        self.tags.map(&:name).join(', ')
    end

    def all_tags=(names)
        self.tags = names.split(',').map do |name|
            Tag.where(name: name.strip).first_or_create!
        end
    end
end
