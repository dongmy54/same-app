# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name: "dmc",
             email: "123@qq.com",
             password: "123456",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)
puts "管理员已创建成功"

99.times do |n|
  name = Faker::Name.unique.name
  email = Faker::Internet.unique.email
  User.create!(:name => name,
               :email => email,
               :password => "password",
               :activated => true,
               :activated_at => Time.zone.now)
  puts "已创建第#{n+1}个"
end