class User < ApplicationRecord
  
  before_save {self.email.downcase!}
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :posts #,dependent: :destroy
  has_many :likes ,dependent: :destroy
  has_many :fav_posts, through: :likes, source: :post #,dependent: :destroy
  
  def favo(post)
    self.likes.find_or_create_by(post_id: post.id)
  end
  
  def unfavo(post)
    xxx=self.likes.find_by(post_id: post.id)
    xxx.destroy if xxx
  end
  
  def likes?(post)
    self.fav_posts.include?(post)
  end
  
end
