# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.find_or_create_by!(email: "admin@example.com") do |admin|
  admin.password = ENV["SECRET_KEY"]
end

olivia = User.find_or_create_by!(email: "olivia@example.com") do |user|
  user.name = "Olivia"
  user.password = "password"
  user.introduction = "よろしくお願いします"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")
end

james = User.find_or_create_by!(email: "james@example.com") do |user|
  user.name = "James"
  user.password = "password"
  user.introduction = "こんにちは"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg")
end

lucas = User.find_or_create_by!(email: "lucas@example.com") do |user|
  user.name = "Lucas"
  user.password = "password"
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
  post.body = '子供はみんな好きだけど、親はあまり推奨しません。'
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