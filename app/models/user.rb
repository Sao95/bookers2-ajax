class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # # foreign_key（FK）には、@user.xxxとした際に「@user.idがfollower_idなのかfollowed_idなのか」を指定します。
  # # has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # # @user.booksのように、@user.yyyで、
  # # そのユーザがフォローしている人orフォローされている人の一覧を出したい
  # has_many :following_user, through: :follower, source: :followed
  # # フォローする人(follower)は中間テーブル(Relationshipのfollower)を通じて(through)、フォローされる人(followed)と紐づく

  # has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # has_many :follower_user, through: :followed, source: :follower
  # # フォローされる人(followed) は中間テーブル(Relationshipのfollowed)を通じて(through)、 フォローする人(follower) と紐づく
  has_many :relationships, foreign_key: "follower_id"
  
  has_many :followings, through: :relationships, source: :followed

  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'followed_id'
  has_many :followers, through: :reverse_of_relationships, source: :follower


  # ユーザーをフォローする
  def follow(another_user)
    unless self == another_user
      self.relationships.find_or_create_by(followed_id: another_user.id)
    end
  end

  # ユーザーのフォローを外す
  def unfollow(another_user)
    unless self == another_user
      relationship = self.relationships.find_by(followed_id: another_user.id)
      relationship.destroy if relationship
    end
  end

  # フォロー確認をおこなう
  def following?(another_user)
    self.followings.include?(another_user)
  end

  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction,length: {maximum: 50}
end
