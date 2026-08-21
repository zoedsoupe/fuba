defmodule Fuba.Repo.Migrations.CriarCoelhinha do
  use Ecto.Migration

  def change do
    create table(:coelhinha) do
      add :nome, :string, null: false, default: "Fubá"
      add :biscoito, :integer, null: false
      add :cafeina, :integer, null: false
      add :carinho, :integer, null: false
      add :energia, :integer, null: false
    end
  end
end
