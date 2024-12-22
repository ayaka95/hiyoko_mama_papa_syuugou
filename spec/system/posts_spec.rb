require 'rails_helper'

describe '投稿のテスト' do
  let!(:user) { create(:user) }
  let!(:post) { create(:post, user: user)}
  
  before do
    visit new_user_session_path
    fill_in 'user[name]', with: user.name
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end

  describe '投稿一覧のテスト' do
    before do
      visit posts_path
    end
    context '表示の確認' do
      it 'posts_pathが"/posts"であるか' do
        expect(current_path).to eq('/posts')
      end
      it '投稿ボタンが表示されているか' do
        expect(page).to have_button '投稿'
      end
    end
    context '投稿処理のテスト' do
      it '投稿後のリダイレクト先は正しいか' do
        fill_in 'post_title', with: Faker::Lorem.characters(number:10)
        fill_in 'post_body', with: Faker::Lorem.characters(number:50)
        click_button '投稿'
        expect(page).to have_current_path post_path(Post.last)
      end
    end
  end

end
