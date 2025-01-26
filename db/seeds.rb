# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'dotenv/load'

Admin.find_or_create_by!(email: "admin@example.com") do |admin|
  admin.password = ENV["SECRET_KEY"]
end

olivia = User.find_or_create_by!(email: "olivia@example.com") do |user|
  user.name = "Olivia"
  user.password = "password"
  user.password_confirmation = "password"
  user.introduction = "よろしくお願いします"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")
end

james = User.find_or_create_by!(email: "james@example.com") do |user|
  user.name = "James"
  user.password = "password"
  user.password_confirmation = "password"
  user.introduction = "こんにちは"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg")
end

lucas = User.find_or_create_by!(email: "lucas@example.com") do |user|
  user.name = "Lucas"
  user.password = "password"
  user.password_confirmation = "password"
  user.introduction = "初めまして"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename:"sample-user3.jpg")
end

Post.find_or_create_by!(title: "寝かしつけドライブ") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg")
  post.body = "昼寝しないときは車に乗せます。"
  post.user = olivia
end

Post.find_or_create_by!(title: "涼しくなりました") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename:"sample-post2.jpg")
  post.body = "日中に公園で遊べるようになり、おおはしゃぎです。"
  post.user = james
end

Post.find_or_create_by!(title: "砂遊び") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename:"sample-post3.jpg")
  post.body = "子供はみんな好きだけど、親はあまり好きではありません。"
  post.user = lucas
end

Post.find do |post|
  PostComment.find_or_create_by!(comment: "素敵な投稿ですね！") do |comment|
    comment.user = james
    comment.post = Post.find_by(title: "寝かしつけドライブ")
  end
end

Post.find do |post|
  PostComment.find_or_create_by!(comment: "楽しそうな日常ですね！") do |comment|
    comment.user = lucas
    comment.post = Post.find_by(title: "涼しくなりました")
  end
end

Post.find do |post|
  PostComment.find_or_create_by!(comment: "子供の成長を感じますね。") do |comment|
    comment.user = olivia
    comment.post = Post.find_by(title: "砂遊び")
  end
end

users = User.all

users.each do |user|
  random_post = Post.all.sample
  Favorite.create(user: user, post: random_post)
end

3.times do |n|
  owner = User.all.sample
  group = Group.find_or_create_by!(
    name: "test#{n + 1}",
    introduction: "test#{n + 1}",
    owner: owner
    )
  group.users << owner
end

GroupPost.find_or_create_by!(title: "保育園") do |group_post|
  group_post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg")
  group_post.body = "入園してすぐは、登園すれば何かしら病気をもらってきます。"
  group_post.group = Group.all.sample
  user = group_post.group.users.sample
  group_user = GroupUser.find_by(group: group_post.group, user: user)
  group_post.group_user = group_user
end

GroupPost.find_or_create_by!(title: "2歳") do |group_post|
  group_post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename:"sample-post2.jpg")
  group_post.body = "言葉も行動範囲もどんどん広がり、成長が楽しみです。"
  group_post.group = Group.all.sample
  user = group_post.group.users.sample
  group_user = GroupUser.find_by(group: group_post.group, user: user)
  group_post.group_user = group_user
end

GroupPost.find_or_create_by!(title: "幼児教育") do |group_post|
  group_post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename:"sample-post3.jpg")
  group_post.body = "たくさん種を蒔いてあげたいと思います。"
  group_post.group = Group.all.sample
  user = group_post.group.users.sample
  group_user = GroupUser.find_by(group: group_post.group, user: user)
  group_post.group_user = group_user
end


