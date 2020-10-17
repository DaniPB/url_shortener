require 'dry/monads'
require 'dry/monads/do'

class Links::Index::Execute
  include Dry::Monads[:result]

  def call
    links = Link.all.order(visits: :desc)

    if links.present?
      Success links
    else
      Failure Errors.general_error("There are no links", self.class)
    end
  end
end
