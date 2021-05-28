# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Exaac.Repo.insert!(%Exaac.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Exaac.Articles

Articles.create_with_title_and_content!("Welcome to ExAAC", "Welcome to this amazing Elixir AAC!")
