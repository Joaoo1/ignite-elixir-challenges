defmodule Exmeal.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias Exmeal.Meal

  @derive {Jason.Encoder, only: [:cpf, :id, :email, :name]}

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:cpf, :email, :name]

  schema "users" do
    field(:name, :string)
    field(:cpf, :string)
    field(:email, :string)

    has_many :meals, Meal

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:cpf, min: 11)
    |> validate_format(:email, ~r/@/)
  end
end
