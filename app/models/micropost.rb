class Micropost < ActiveRecord::Base
  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :name, :tag_list
  acts_as_votable
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate :picture_size
  has_many :comments


  private

    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
