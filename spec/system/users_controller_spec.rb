require 'rails_helper'

describe 'ログイン画面のテスト' do
  let!(:user) { create(:user) }
  before do
    visit new_user_session_path
  end
  context '表示内容の確認' do
    it 'new_user_session_pathが"/users/sign_in"であるか' do
      expect(current_path).to eq'/users/sign_in'
    end
    it '名前フォームが表示される' do
      expect(page).to have_field 'user[name]'
    end
    it 'パスワードフォームが表示される' do
      expect(page).to have_field 'user[password]'
    end
    it 'メールフォームは表示されない' do
      expect(page).not_to have_field 'user[email]'
    end
    it 'Log inリンクの内容が正しい' do
      log_in_link = find_all('a')[3].text
      expect(page).to have_link log_in_link, href: new_user_session_path
    end
    it 'Sign upリンクの内容が正しい' do
      sign_up_link = find_all('a')[4].text
      expect(page).to have_link sign_up_link, href: new_user_registration_path
    end
  end
  context 'ログイン成功のテスト' do
    before do
      fill_in 'user[name]', with: user.name
      fill_in 'user[password]', with: user.password
      click_button 'Log in'
    end
    it 'ログイン後のリダイレクト先が、ログインしたユーザーのマイページである' do
      expect(current_path).to eq'/mypage'
    end
  end 
  context 'ログイン失敗のテスト' do
    before do
      fill_in 'user[name]', with: nil
      fill_in 'user[password]', with: nil
      click_button 'Log in'
    end
    it 'ログインに失敗し、ログイン画面にリダイレクトするか' do
      expect(current_path).to eq'/users/sign_in'
    end
  end
end

describe '新規登録画面のテスト' do
  before do
    visit new_user_registration_path
  end
  context '表示内容の確認' do
    it 'new_user_registration_pathが"/users/sign_up"であるか' do
      expect(current_path).to eq'/users/sign_up'
    end
    it '名前フォームが表示される' do
      expect(page).to have_field 'user[name]'
    end
    it 'メールフォームが表示される' do
      expect(page).to have_field 'user[email]'
    end
    it 'パスワードフォームが表示される' do
      expect(page).to have_field 'user[password]'
    end
    it 'パスワード確認画面が表示される' do
      expect(page).to have_field 'user[password_confirmation]'
    end
    it 'Sign upのリンク内容が正しい' do
      sign_up_link = find_all('a')[2].text
      expect(page).to have_link sign_up_link, href: new_user_registration_path
    end
    it 'Log inのリンク内容が正しい' do
      log_in_link = find_all('a')[3].text
      expect(page).to have_link log_in_link, href: new_user_session_path
    end
  end
  context '新規登録成功のテスト' do
    before do
      fill_in 'user[name]', with: '"user_#{n}"'
      fill_in 'user[email]', with: '"user_#{n}@example.com"' 
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
    end
    it '正しく新規登録される' do
      expect{ click_button "Sign up" }.to change(User.all, :count).by(1)
    end
    it '新規登録後のリダイレクト先が、新規登録を行なったユーザーのマイページである' do
      click_button 'Sign up'
      expect(page).to have_current_path('/mypage')
    end
  end
  context '新規登録失敗のテスト' do
    before do
      fill_in 'user[name]', with: nil
      fill_in 'user[email]', with: nil
      fill_in 'user[password]', with: nil
      fill_in 'user[password_confirmation]', with: nil
      click_button 'Sign up'
    end
    it '新規登録に失敗し、新規登録画面にリダイレクトするか' do
      expect(current_path).to eq'/users'
      #新規登録失敗後のリダイレクト画面要修正
      #エラーメッセージと入力フォーム諸々のレイアウト崩れてる
      #エラーメッセージはviews/public/shared/_error_messages.html.erbから来ているようだが、修正反映されない
      #上記の根拠は、id="error_explanation"
    end
  end
end

describe 'ログイン状態でのテスト' do
  let!(:user) { create(:user) }
  before do
    visit new_user_session_path
    fill_in 'user[name]', with: user.name
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end
  context 'マイページ画面のテスト' do
    before do
      visit mypage_path
    end
    it 'プロフィール編集リンクの確認' do
      edit_user_link = find_all('a')[6].text
      expect(page).to have_link edit_user_link, href: edit_user_path(user)
    end
    it '退会リンクの確認' do
      delete_user_link = find_all('a')[7].text
      expect(page).to have_link delete_user_link, href: user_path(user)
    end
    it 'ユーザーの退会処理が正しく行われているか' do
      expect{ click_link "退会" }.to change(User.all, :count).by(-1)
    end
    it '退会後のリダイレクト先が正しい' do
      click_link "退会"
      expect(current_path).to eq'/users/sign_up'
    end
  end
  context 'プロフィール編集画面のテスト' do
    before do
      visit edit_user_path(user)
    end
    it 'edit_user_path(user)が"/users/:id/edit"である' do
      expect(current_path).to eq'/users/' + user.id.to_s + '/edit'
    end
    it '編集前の名前と自己紹介文がセットされているか' do
      expect(page).to have_field 'user[name]', with: user.name
      expect(page).to have_field 'user[introduction]', with: user.introduction
    end
    it '変更を保存ボタンが表示されているか' do
      expect(page).to have_button '変更を保存'
    end
  end
  context 'プロフィール編集画面での更新処理に関するテスト' do
    before do
      visit edit_user_path(user)
      @user_old_name = user.name
      @user_old_introduction = user.introduction
      fill_in 'user[name]', with: '"user_#{n}"'
      fill_in 'user[introduction]', with: Faker::Lorem.characters(number: 100)
      click_button '変更を保存'
    end
    it 'ユーザー名が正しく更新されるか' do
      expect(user.reload.name).not_to eq @user_old_name
    end
    it 'ユーザーの自己紹介文が正しく更新されるか' do
      expect(user.reload.introduction).not_to eq @user_old_intrpduction
    end
  end
  context 'ユーザー一覧のテスト' do
    before do
      visit users_path
    end
    it 'users_pethが"/users"であるか' do
      expect(current_path).to eq'/users'
    end
    it 'ユーザーが一覧表示されていて、リンクが正しいか' do
      expect(page).to have_link user.name, href: user_path(user)
    end
  end
  context 'ユーザー詳細のテスト' do
    before do
      visit user_path(user)
    end
    it 'ユーザー詳細に、ユーザー名が表示されている' do
      expect(page).to have_content user.name
    end
    it 'ユーザー詳細に、自己紹介が表示されている' do
      expect(page).to have_content user.introduction
    end
  end
end

describe 'ログアウトのテスト' do
  let(:user) { create(:user) }
  before do
    visit new_user_session_path
    fill_in 'user[name]', with: user.name
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
    logout_link = find_all('a')[5].text
    click_link logout_link
  end
  it 'ログアウト後のリダイレクト先が、ログイン画面になっている' do
    expect(page).to have_current_path('/users/sign_in')
  end
end






  