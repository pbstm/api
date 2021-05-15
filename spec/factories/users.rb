FactoryBot.define do
	factory :user do
		email { Faker::Internet.unique.email }
		name { Faker::Name.name }
		password { '123123' }
	end
end
