module Errors

  def self.general_error(message, location, extra = {})
    { message: message, location: location, extra: extra }
  end

  def self.model_error(error, model, extra = {})
    { message: error, model: model, extra: extra }
  end
end
