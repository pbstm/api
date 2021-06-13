ENV[ 'RAILS_ENV' ] = 'test'

require 'spec_helper'

require File.expand_path( '../config/environment', __dir__ )
abort( 'The Rails environment is running in production mode!' ) if Rails.env.production?
require 'rspec/rails'
SECRET_JWT_KEY = Rails.configuration.jwt_secret_key

Dir[ Rails.root.join( 'spec', 'docs', '**', '*.rb' ) ].each { | file | require file }
Dir[ Rails.root.join( 'spec', 'support', '**', '*.rb' ) ].each { | file | require file }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => error
  puts error.to_s.strip
  exit 1
end

RSpec.configure do | config |
  config.include Helpers::DateFormat
  config.include Helpers::FixtureFiles
  config.include Helpers::Request, type: :request
  config.include Helpers::Responses, type: :request

  config.fixture_path = Rails.root.join 'spec', 'fixtures'

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end

Shoulda::Matchers.configure do | config |
  config.integrate do | with |
    with.test_framework :rspec
    with.library :rails
  end
end
