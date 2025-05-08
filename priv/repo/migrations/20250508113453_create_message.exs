defmodule Slax.Repo.Migrations.CreateMessage do
  use Ecto.Migration

  def change do
    create table(:message) do
      add :body, :text, null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :room_id, references(:rooms, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:message, [:user_id])
    create index(:message, [:room_id])
  end
end
