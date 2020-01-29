class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_many :friend_requests, dependent: :destroy
  has_many :pending_friends, through: :friend_requests, source: :friend
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  # Returns a user's status feed.

  def feed
    friend_ids = "SELECT friend_id FROM friendships
                     WHERE  user_id = :user_id"
    Post.where("user_id IN (#{friend_ids})
                     OR user_id = :user_id", user_id: id)
  end

  def remove_friend(friend)
    self.friends.destroy(friend)
  end

  # oauth sign in
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.password = Devise.friendly_token[0,20]
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.first_name = auth.info.name.split(" ").first   # assuming the user model has a name
      user.last_name = auth.info.name.split(" ").last 
      user.save!
    end
  end

end
