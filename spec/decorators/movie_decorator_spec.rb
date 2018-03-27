require "rails_helper"


RSpec.describe MovieDecorator do
  describe 'formatted_released_at' do
    let(:movie) { create(:movie, :created_21_03_2018) }
    it { expect(movie.decorate.formatted_released_at).to eq('21.03.2018') }
  end
end
