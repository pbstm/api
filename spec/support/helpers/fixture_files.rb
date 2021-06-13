module Helpers
  module FixtureFiles
    def image_file
      @image_file ||= file_fixture( 'test.jpg' ).read
    end
  end
end
