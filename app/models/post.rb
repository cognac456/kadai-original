class Post < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :location, presence: true
  validates :image, presence: true
  
  has_many :likes ,dependent: :destroy
  has_many :fav_users, through: :likes, source: :user #,dependent: :destroy
  
  mount_uploader :image, ImageUploader #Model Post.imageと、アップローダーImageUploaderとをひも付け。
end
