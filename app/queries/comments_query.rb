class CommentsQuery
  def initialize(relation = Comment.all)
    @relation = relation
  end

  def find_top_10_commenters
    @relation
      .joins(:user)
      .group('users.name')
      .where('comments.created_at >= ?', 7.days.ago)
      .order('comments_count desc')
      .limit(10)
      .pluck('users.name, COUNT(comments.id) AS comments_count')
  end
end
