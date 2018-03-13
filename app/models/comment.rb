class Comment < ApplicationRecord
  validates :message, presence: true
  belongs_to :user, class_name: 'User', foreign_key: 'author_id'
  belongs_to :movie
  validates_uniqueness_of :movie_id, scope: :author_id

  scope :user_comment_on_movie, ->(movie_id, user_id) do
    where('movie_id = ? AND author_id = ?', movie_id, user_id)
  end
end
