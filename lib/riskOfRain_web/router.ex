defmodule RiskOfRainWeb.Router do
  use RiskOfRainWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RiskOfRainWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/items", ItemController
    resources "/enemies", EnemyController
    resources "/characters", CharacterController


  end

  # Other scopes may use custom stacks.
  # scope "/api", RiskOfRainWeb do
  #   pipe_through :api
  # end
end
