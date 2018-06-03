require 'rails_helper'

RSpec.describe MovieDecorator do
  describe 'formatted_released_at' do
    let(:movie) { build_stubbed(:movie, released_at: Date.new(2018,03,21)) }
    it { expect(movie.decorate.formatted_released_at).to eq('21.03.2018') }
  end
end
