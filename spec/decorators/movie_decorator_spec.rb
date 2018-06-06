require 'rails_helper'

RSpec.describe MovieDecorator do
  let(:movie) { build_stubbed(:movie, released_at: Date.new(2018,03,21)) }
  let(:values) {
    {
      poster: 'test poster',
      rating: 6.0,
      plot: 'test plot'
    }
  }

  describe 'formatted_released_at' do
     it { expect(movie.decorate.formatted_released_at).to eq('21.03.2018') }
  end
  
  before(:each) { allow_any_instance_of(described_class).to receive(:values).and_return(values) }

  describe '#rating #plot #poster' do
    before(:each) { allow_any_instance_of(described_class).to receive(:values).and_return(values) }
    it { expect(movie.decorate.rating).to eq(6.0) }
    it { expect(movie.decorate.plot).to eq('test plot') }
    it { expect(movie.decorate.poster).to eq('test poster') }
  end
end
