class UsersBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :name, :email
  end

  view :extended do
    include_view :normal
    field :created_at
    field :updated_at
    field :avatar_url
    field :type
  end
end
