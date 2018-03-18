require "rails_helper"

RSpec.describe Comment, type: :model do
  describe 'checking basic validations:' do
    it { should belong_to(:user) }
    it { should allow_value(1).for(:id) }
    it { should belong_to(:movie) }
    it { should validate_presence_of(:message) }
    it { should validate_uniqueness_of(:movie_id).scoped_to(:author_id) }
  end
end
