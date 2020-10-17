module Errors

  def self.general_error(message, location, extra = {})
    { message: message, location: location, extra: extra }
  end
end
