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
end
