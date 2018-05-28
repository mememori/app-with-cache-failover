defmodule MyAppWeb.Router do
  use MyAppWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", MyAppWeb do
    pipe_through(:api)

    get("/customers", ProfileController, :index)
    post("/customers", ProfileController, :create_many)
    delete("/customers", ProfileController, :delete_all)
  end
end
