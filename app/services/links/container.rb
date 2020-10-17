class Links::Container
  extend Dry::Container::Mixin

  register("create_link") { -> input { Links::Create::Do.new.(input) } }

  Import = Dry::AutoInject(Links::Container)
end

