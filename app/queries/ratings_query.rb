class RatingsQuery
  def initialize(movie_id)
    @relation = Rating.where(movie_id: movie_id)
  end

  def average_rating
    @relation.average(:score)
  end
end
