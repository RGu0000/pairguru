require "rails_helper"

RSpec.describe CommentsQuery do
  subject { described_class.new.find_top_10_commenters }

  context "when there is less than 10 users" do
    let!(:user) { create(:user, :with_10_comments_last_week) }
    let!(:user2) { create(:user, :with_5_comments_last_week) }

    it { expect(subject.first.comments_count).to eq(10) }
    it { expect(subject.second.comments_count).to eq(5) }
  end
end
