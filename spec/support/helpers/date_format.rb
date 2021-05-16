module Helpers
  module DateFormat
    def rfc3339( date )
      date.to_datetime.rfc3339
    end
  end
end
