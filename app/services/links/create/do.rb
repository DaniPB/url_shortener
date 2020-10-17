require 'dry/monads'
require 'dry/monads/do'

class Links::Create::Do
  include Dry::Monads[:result]
  include Dry::Monads::Do.for(:call)

  def call(input)
    values = yield define_shortcut(input)
    final_values = yield define_new_address(input)
    link = yield create_link(values)

    Success link
  end

  def define_shortcut(input)
    if input[:shortcut].nil?
      shortcut = generate_shortcut

      input.merge!(shortcut: shortcut)
    end

    Success input
  end

  def generate_shortcut
    shortcut = SecureRandom.alphanumeric(10)
    link = Link.find_by(shortcut: shortcut)

    if link.present?
      generate_shortcut
    else
      shortcut
    end
  end

  def create_link(link_values)
    link = Link.new(link_values)

    if link.save
      Success(link: link)
    else
      errors = link.errors.messages

      Failure Errors.model_error("Creation failed", Link, errors)
    end
  end

  def define_new_address(link_values)
    address = "#{ENV["SERVER_URL"]}/#{link_values[:shortcut]}"

    Success link_values.merge!(new_address: address)
  end
end
