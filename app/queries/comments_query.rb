class CommentsQuery
  def initialize(relation = Comment.all)
  @relation = relation
  end

  def find_top_10_commenters
    @relation
      .joins(:user)
      .where('comments.created_at >= ?', 7.days.ago)
      .group(:name)
      .order('count_all desc')
      .limit(10)
      .count
      .to_a
  end
end
