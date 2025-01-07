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
      before do
        fill_in 'post[title]', with: Faker::Lorem.characters(number:10)
        fill_in 'post[body]', with: Faker::Lorem.characters(number:50)
      end
      it '投稿が正しく保存されるか' do
        expect{ click_button '投稿' }.to change(user.posts, :count).by(1)
      end
      it 'リダイレクト先が、投稿の詳細画面になっている' do
        click_button '投稿'
        expect(page).to have_current_path post_path(Post.last)
      end
      it '投稿失敗後の遷移先が正しいか' do
        fill_in 'post[title]', with: nil
        click_button '投稿'
        expect(page).to have_current_path posts_path
      end
    end
    context '投稿した内容が一覧表示されているか' do
      it 'タイトルが表示され、リンクが正しいか' do
        expect(page).to have_link post.title, href: post_path(post)
      end
    end
  end

  describe 'ユーザー詳細画面のテスト' do
    before do
      visit user_path(user)
    end
    it 'ユーザーが投稿した投稿のタイトルが表示されていて、リンクが正しいか' do
      expect(page).to have_link post.title, href: post_path(post)
    end
  end

  describe '投稿詳細のテスト：自分が投稿した投稿の場合' do
    before do
      visit posts_path
      fill_in 'post[title]', with: Faker::Lorem.characters(number:10)
      fill_in 'post[body]', with: Faker::Lorem.characters(number:50)
      click_button '投稿'
      visit post_path(post)
    end
    context '表示の確認' do
      it 'post_pathが"/posts/:id"であるか' do
        expect(current_path).to eq'/posts/' + post.id.to_s
      end
      it '編集リンクが表示されているか' do
        expect(page).to have_link "編集", href: edit_post_path(post)
      end
      it '削除リンクが表示されているか' do
        expect(page).to have_link "削除", href: post_path(post)
      end
    end
    context '削除が成功した時' do
      it '削除されるか' do
        expect{ post.destroy }.to change(Post, :count).by(-1)
      end
      it '削除後のリダイレクト先が正しいか' do
        click_link '削除'
        expect(page).to have_current_path mypage_path
      end
    end
  end

  describe '編集画面のテスト' do
    before do
      visit edit_post_path(post)
    end
    context '表示の確認' do
      it 'edit_post_pathが"/posts/:id/edit"であるか' do
        expect(current_path).to eq'/posts/' + post.id.to_s + '/edit'
      end
      it '編集前のタイトルと本文がフォームにセットされているか' do
        expect(page).to have_field 'post[title]', with: post.title
        expect(page).to have_field 'post[body]', with: post.body
      end
      it '保存ボタンが表示されている' do
        expect(page).to have_button '保存'
      end
    end
    context '更新処理に関するテスト' do
      before do
        @post_old_title = post.title
        @post_old_body = post.body
        fill_in 'post[title]', with: Faker::Lorem.characters(number:10)
        fill_in 'post[body]', with: Faker::Lorem.characters(number:50)
        click_button '保存'
      end
      it 'タイトルが正しく更新されるか' do
        expect(post.reload.title).not_to eq @post_old_title
      end
      it '本文が正しく更新されるか' do
        expect(post.reload.body).not_to eq @post_old_body
      end
      it '更新後のリダイレクト先が、更新した投稿の詳細画面になっているか' do
        expect(current_path).to eq '/posts/' + post.id.to_s
      end
    end
  end
end
