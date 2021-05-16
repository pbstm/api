RSpec.configure do | config |
  config.include FactoryBot::Syntax::Methods

  config.after :each do
    Faker::UniqueGenerator.clear
  end
end
