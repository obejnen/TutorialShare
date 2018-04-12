class Tutorial < ApplicationRecord
    mount_uploader :image, ImageUploader
    ratyrate_rateable "rating"

    has_many :taggings, dependent: :destroy
    has_many :tags, through: :taggings
    has_many :comments, as: :commentable, dependent: :destroy
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

    def rating
        stars = Rate.where(rateable_id: id, rateable_type: 'Tutorial').map {|tutorial| tutorial.stars}
        stars_total = stars.sum
        score = stars_total / (stars.count.nonzero? || 1)
    end

    def recent
        user = params.require(:tutorial).permit(:user_id)
        params.require(:tutorial).permit(:title, :description, :body, :image, :all_tags, :category_id).
        merge(user_id: user[:id] == current_user.id || current_user.admin? ? user[:id].to_i : current_user.id)
    end
end