module CommentServices
  class FindTopCommenters
    def call
      Comment
        .joins(:user)
        .where('comments.created_at >= ?', 7.days.ago)
        .group(:name)
        .order('count_all desc')
        .having('count_all > ?', 0)
        .limit(10)
        .count
    end
  end
end
