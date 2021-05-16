require 'spec_helper'
ENV[ 'RAILS_ENV' ] ||= 'test'
require File.expand_path( '../config/environment', __dir__ )
abort( 'The Rails environment is running in production mode!' ) if Rails.env.production?
require 'rspec/rails'
SECRET_JWT_KEY = Rails.configuration.jwt_secret_key

Dir[ Rails.root.join( 'spec', 'docs', '**', '*.rb' ) ].each { | f | require f }
Dir[ Rails.root.join( 'spec', 'support', '**', '*.rb' ) ].each { | f | require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => error
  puts error.to_s.strip
  exit 1
end

Shoulda::Matchers.configure do | config |
  config.integrate do | with |
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do | config |
  config.include Helpers::DateFormat
  config.include Helpers::Request, type: :request
  config.include Helpers::Responses, type: :request

  config.fixture_path = "#{ ::Rails.root }/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
