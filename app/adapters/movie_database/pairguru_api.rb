module MovieDatabase
  class PairguruApi
    URL = 'https://pairguru-api.herokuapp.com/api/v1/movies/'.freeze
    # attributes = %i[poster rating plot]

    attr_accessor :poster, :rating, :plot

    def initialize(title)
      @connection = Faraday.new(url: URL)
      @title = title
    end

    def call
      response = @connection.get(title_to_url)
      JSON.parse(response.body, symbolize_names: true)[:data][:attributes]
    end

    private

    def title_to_url
      words = @title.split(' ')
      if words.length == 1
        @title.capitalize
      else
        words.map(&:capitalize).join('%20')
      end
    end
  end
end
