defmodule EmqxInspectWeb.Router do
  use EmqxInspectWeb, :router
  import Phoenix.LiveDashboard.Router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", EmqxInspectWeb do
    pipe_through :api
  end

  scope "/inspect" do
    pipe_through [:fetch_session, :protect_from_forgery]

    live_dashboard "/dashboard", metrics: EmqxInspectWeb.Telemetry
  end
end
