require 'rails_helper'

describe '投稿のテスト' do
  let!(:user) { create(:user) }
  let!(:post) { create(:post, user: user)}
  
  before do
    visit new_user_session_path
    fill_in 'user[name]', with: user.name
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
    post = create(:post, user: user)
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
      before do
        fill_in 'post_title', with: Faker::Lorem.characters(number:10)
        fill_in 'post_body', with: Faker::Lorem.characters(number:50)
      end
      it '投稿が正しく保存されるか' do
        expect{ click_button '投稿' }.to change(user.posts, :count).by(1)
      end
      it 'リダイレクト先が、投稿の詳細画面になっている' do
        click_button '投稿'
        expect(page).to have_current_path post_path(Post.last)
      end
    end
    context '投稿が失敗した時' do
      it '投稿失敗後の遷移先が正しいか' do
        fill_in 'post_title', with: nil
        click_button '投稿'
        expect(page).to have_current_path posts_path
      end
    end
  end

  describe '投稿詳細のテスト：自分が投稿した投稿の場合' do
    before do
      visit posts_path
      fill_in 'post_title', with: Faker::Lorem.characters(number:10)
      fill_in 'post_body', with: Faker::Lorem.characters(number:50)
      click_button '投稿'
      visit post_path(Post.last)
    end
    context '表示の確認' do
      it '編集リンクが表示されているか' do
        expect(page).to have_link "編集", href: edit_post_path(Post.last)
      end
      it '削除リンクが表示されているか' do
        expect(page).to have_link "削除", href: post_path(Post.last)
      end
    end
    context '削除が成功した時' do
      it '削除後のリダイレクト先が正しいか' do
        click_link '削除'
        expect(page).to have_current_path mypage_path
      end
      it '削除されるか' do
        expect{ post.destroy }.to change(Post, :count).by(-1)
      end
    end
  end
end
