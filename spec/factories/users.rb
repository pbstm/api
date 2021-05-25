FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    name { Faker::Name.name }
    password { '123123' }
    avatar { Faker::Avatar.image( slug: 'slug', size: '150x150' ) }
  end
end
