class Comment < ApplicationRecord
  validates :message, presence: true
  belongs_to :user, class_name: 'User', foreign_key: 'author_id'
  belongs_to :movie
  validates_uniqueness_of :movie_id, scope: :author_id
end
