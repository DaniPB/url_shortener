require 'dry/monads'
require 'dry/monads/do'

class Links::Show::Execute
  include Dry::Monads[:result]
  include Dry::Monads::Do.for(:call)

  def call(input)
    values = yield validate(input)
    #link = yield create_link.(input)
    link = yield search_link(values)

    Success link
  end

  def validate(input)
    validation = Links::Validators::ShowSchema.(input)

    if validation.success?
      Success input
    else
      errors = validation.errors.to_h

      Failure Errors.general_error("Validation failed", self.class, errors)
    end
  end

  def search_link(values)
    shortcut = values[:shortcut]
    link = Link.find_by(shortcut: shortcut)

    if link.present?
      Success(link: link)
    else
      Failure Errors.general_error("Link #{shortcut} not found", self.class)
    end
  end
end
