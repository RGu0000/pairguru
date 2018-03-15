require "rails_helper"

RSpec.describe Comment, type: :model do
  describe 'checking validations:' do
    it { should belong_to(:user) }
    it { should belong_to(:movie) }
    it { validate_presence_of :created_at }
    it { validate_presence_of :message }
  end
end
