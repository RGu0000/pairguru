class MovieDecorator < Draper::Decorator
  delegate_all

  def cover
    'http://lorempixel.com/100/150/' +
      %w[abstract nightlife transport].sample +
      '?a=' + SecureRandom.uuid
  end

  def formatted_released_at
    released_at.strftime('%d.%m.%Y')
  end

  def movie_found?
    values.values.exclude? nil
  end

  %w[poster rating plot].each do |method_name|
    define_method(method_name) do
      values[method_name.to_sym]
    end
  end

  private

  def values
    return @values if @values.present?
    @values = MovieDatabase::PairguruApi.new(object.title).call
  end

  def formatted_released_at
    released_at.strftime('%d.%m.%Y')
  end
end
