class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :omniauthable,
         omniauth_providers: [:google_oauth2]
  has_many :tweets
  has_many :comments, dependent: :destroy
  has_one_attached :image

  has_many :active_relationships,
           class_name: "Relationship",
           foreign_key: "follower_id",
           dependent: :destroy

  has_many :passive_relationships,
           class_name: "Relationship",
           foreign_key: "followed_id",
           dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed

  has_many :followers, through: :passive_relationships, source: :follower

  scope :all_except, ->(user) { where.not(id: user.id) }

  def username
    return email.split("@")[0].capitalize
  end

  # def self.from_omniauth(auth)
  #   name_split = auth.info.name.split(" ")
  #   user = User.where(email: auth.info.email).first
  #   user ||=
  #     User.create!(
  #       provider: auth.provider,
  #       uid: auth.uid,
  #       email: auth.info.email,
  #       password: Devise.friendly_token[0, 20]
  #     )
  #   user
  # end
  #

  # Follows a user.
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # Unfollows a user.
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  def self.from_google(email:, uid:, password:)
    create_with(uid: uid).find_or_create_by!(email: email, password: password)
  end
end
