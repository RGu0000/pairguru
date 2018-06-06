module MovieDatabase
  class PairguruApi
    URL = 'https://pairguru-api.herokuapp.com/api/v1/movies/'.freeze

    attr_accessor :poster, :rating, :plot

    def initialize(title)
      @connection = Faraday.new(url: URL)
      @title = title
    end

    def call
      response = @connection.get(title_to_url)
      if response.body["Couldn't find Movie"].nil?
        assign_attributes(JSON.parse(response.body, symbolize_names: true)[:data][:attributes])
      else
        assign_attributes({})
      end
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

    def assign_attributes(hash)
      @rating = hash[:rating]
      @plot = hash[:plot]
      @poster = hash[:poster]
      instance_values.symbolize_keys.slice(:poster, :rating, :plot)
    end
  end
end
