FactoryBot.define do
  factory :photo_session do
    photographer
    location
    title { Faker::Company.name }
    description { Faker::Lorem.paragraph }
    cover { Rack::Test::UploadedFile.new( 'spec/fixtures/files/test.jpg' ) }
  end
end
