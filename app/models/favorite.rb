class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates_uniqueness_of :book_id, scope: :user_id
  # favoritesデーブルに、同一のuser_idに対するbook_idは一意である
end
