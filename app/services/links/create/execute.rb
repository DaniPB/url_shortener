require 'dry/monads'
require 'dry/monads/do'

class Links::Create::Execute
  include Dry::Monads[:result]
  include Dry::Monads::Do.for(:call)
  include Links::Container::Import["create_link"]

  def call(input)
    values = yield validate(input)
    link = yield create_link.(input)

    Success link
  end

  def validate(input)
    validation = Links::Validators::CreateSchema.(input)

    if validation.success?
      Success input
    else
      errors = validation.errors.to_h

      Failure Errors.general_error("Validation failed", self.class, errors)
    end
  end
end
