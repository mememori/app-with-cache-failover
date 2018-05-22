defmodule MyApp.Repo do
  use Ecto.Repo, otp_app: :my_app

  def init(_, opts) do
    username = System.get_env("DATABASE_USERNAME") || opts[:username] || "postgres"
    password = System.get_env("DATABASE_PASSWORD") || opts[:password] || "postgres"
    hostname = System.get_env("DATABASE_HOSTNAME") || opts[:hostname] || "localhost"

    opts =
      opts
      |> Keyword.put(:url, System.get_env("DATABASE_URL"))
      |> Keyword.put(:username, username)
      |> Keyword.put(:password, password)
      |> Keyword.put(:hostname, hostname)

    {:ok, opts}
  end
end
