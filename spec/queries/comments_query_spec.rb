require "rails_helper"

RSpec.describe CommentsQuery do
  subject { described_class.new.find_top_10_commenters }

  describe 'when there is less than 10 users' do
    let!(:user_list) { create_list(:user, 3, :with_10_comments_last_week)}
    let!(:user_list2) { create_list(:user, 4, :with_5_comments_last_week)}
    let!(:user_list3) { create_list(:user, 2)}

    context 'top user has 10 comments' do
      it { expect(subject.first.comments_count).to eq(10) }
    end

    context 'last user has 5 comments' do
      it { expect(subject.last.comments_count).to eq(5) }
    end

    context 'Query finds 7 users with comments_count > 0' do
      it { expect(subject.all.length).to eq(7) }
    end
  end

  describe 'when there is more than 10 users' do
    let!(:user_list) { create_list(:user, 5, :with_10_comments_last_week)}
    let!(:user_list2) { create_list(:user, 7, :with_5_comments_last_week)}
    let!(:user_list3) { create_list(:user, 2)}

    context 'first user has 10 comments' do
      it { expect(subject.first.comments_count).to eq(10) }
    end

    context 'last user has 5 comments' do
      it { expect(subject.last.comments_count).to eq(5) }
    end

    context 'Query finds 10 users' do
      it { expect(subject.all.length).to eq(10) }
    end
  end
end
