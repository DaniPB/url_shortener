require "dry/validation"
module Links::Validators

  CreateSchema = Dry::Schema.Params do
    required(:address).filled(:string)
    optional(:shortcut).value(:string)
  end
  
  ShowSchema = Dry::Schema.Params do
    required(:shortcut).filled(:string)
  end
end
