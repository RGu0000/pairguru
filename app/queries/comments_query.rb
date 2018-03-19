class CommentsQuery
  def initialize(relation = Comment.all)
    @relation = relation
  end

  def find_top_10_commenters
    @relation
      .joins(:user)
      .select('users.name, COUNT(comments.id) AS comments_count')
      .where('comments.created_at >= ?', 7.days.ago)
      .group('users.name')
      .order('comments_count desc')
      .limit(10)
  end
end
