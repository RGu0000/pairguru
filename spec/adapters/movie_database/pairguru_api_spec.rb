require 'rails_helper'

RSpec.describe MovieDatabase::PairguruApi do
  let(:connection) { double }
  let(:response) { double }
  let(:title) { "title" }
  let(:title_to_url) { double }
  let(:rating) { 6.5 }
  let(:plot) { 'plot' }
  let(:poster) { 'test/url' }
  let(:body) {
    {
      'data' => {
        'attributes' => {
            'poster' => poster,
            'rating' => rating,
            'plot' => plot
          }
      }
    }.to_json
  }

  describe 'call' do
    subject { described_class.new(title).call }

    before do
      allow(Faraday).to receive(:new) { connection }
      allow(connection).to receive(:get).and_return(response)
      allow(response).to receive(:body) { body }
    end

    it { expect(subject[:rating]).to eq(rating) }
    it { expect(subject[:plot]).to eq(plot) }
    it { expect(subject[:poster]).to eq(poster) }
  end
end
