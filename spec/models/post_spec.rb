require 'rails_helper'

describe 'バリデーションのテスト' do
  subject { post.valid? }

  let(:user) { create(:user) }
  let!(:post) { build(:post, user_id: user.id) }

  context 'titleカラム' do
    it '空欄でないこと' do
      post.title = ''
      is_expected.to eq false
    end
    it '30文字以下で投稿に成功した場合' do
      post.title = Faker::Lorem.characters(number: 30)
      is_expected.to eq true
    end
    it '31文字で投稿に失敗した場合' do
      post.title = Faker::Lorem.characters(number: 31)
      is_expected.to eq false
    end
  end
  context 'bodyカラム' do
    it '空欄でないこと' do
      post.body = ''
      is_expected.to eq false
    end
    it '100文字以下で投稿に成功した場合' do
      post.body = Faker::Lorem.characters(number: 100)
      is_expected.to eq true
    end
    it '101文字で投稿に失敗した場合' do
      post.body = Faker::Lorem.characters(number: 101)
      is_expected.to eq false
    end
  end
end

describe 'アソシエーションのテスト' do
  context 'userモデルとの関係' do
    it 'N:1になっている' do
      expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
    end
  end
end