FactoryBot.define do
  factory :photo_session_photo do
    photo_session
    photo { Rack::Test::UploadedFile.new( 'spec/fixtures/files/test.jpg' ) }
  end
end
