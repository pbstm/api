FactoryBot.define do
  factory :photo_session do
    title { ' MyString ' }
    description { 'MyText' }
    photographer_id { '' }
    foreign_key_to_users { '' }
    cover { 'MyString' }
    mount_image { 'MyString' }
  end
end
