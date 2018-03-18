require "rails_helper"

RSpec.describe CommentsQuery do
  subject { described_class.new.find_top_10_commenters }

  context "when there is less than 10 users" do
    let!(:user) { create(:user, :with_10_comments_last_week) }
    let!(:user2) { create(:user, :with_5_comments_last_week) }

    describe 'user has 10 comments' do
      it { expect(subject.first.comments_count).to eq(10) }
    end

    describe 'user2 has 5 comments' do
      it { expect(subject.first.comments_count).to eq(5) }
    end

    describe 'Query finds 2 users' do
      it { expect(subject.all.length).to eq(2) }
    end
  end
end
