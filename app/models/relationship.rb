class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User" # FollowクラスではなくUserクラスであることを明示
  belongs_to :followed, class_name: "User"
end
