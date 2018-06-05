class MovieDecorator < Draper::Decorator
  delegate_all

  def cover
    'http://lorempixel.com/100/150/' +
      %w[abstract nightlife transport].sample +
      '?a=' + SecureRandom.uuid
  end

  %w[poster rating plot].each do |method_name|
    define_method(method_name) do
      # binding.pry
      values[method_name.to_sym]
    end
  end

  private

  def values
    return @values if @values.present?
    @values = MovieDatabase::PairguruApi.new(object.title).call
  end
end
