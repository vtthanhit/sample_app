User.create!(name: "Example User", email: "example@mail.com", password: "password", password_confirmation: "password", admin: true)
99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@mail.com"
  password = "password"
  User.create!(name: name, email: email, password: password, password_confirmation: password)
end
