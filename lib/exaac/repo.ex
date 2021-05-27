defmodule Exaac.Repo do
  use Ecto.Repo,
    otp_app: :exaac,
    adapter: Ecto.Adapters.MyXQL
end
