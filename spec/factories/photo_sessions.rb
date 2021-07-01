FactoryBot.define do
  factory :photo_session do
    title { ' MyString ' }
    description { 'MyText' }
    photographer_id { '' }
    foreign_key { 'MyString' }
    to { 'MyString' }
    user { '' }
    cover { 'MyString' }
    mount { 'MyString' }
    image { 'MyString' }
  end
end
