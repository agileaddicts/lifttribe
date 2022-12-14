defmodule LifttribeWeb.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  Finally, if the test case interacts with the database,
  we enable the SQL sandbox, so changes done to the database
  are reverted at the end of every test. If you are using
  PostgreSQL, you can even run database tests asynchronously
  by setting `use LifttribeWeb.ConnCase, async: true`, although
  this option is not recommended for other databases.
  """

  use ExUnit.CaseTemplate

  alias Ecto.Adapters.SQL.Sandbox
  alias Lifttribe.Repo
  alias Phoenix.ConnTest
  alias Plug.Conn

  using do
    quote do
      # Import conveniences for testing with connections
      import Plug.Conn
      import Phoenix.ConnTest
      import LifttribeWeb.ConnCase

      alias LifttribeWeb.Router.Helpers, as: Routes

      # The default endpoint for testing
      @endpoint LifttribeWeb.Endpoint
    end
  end

  setup tags do
    pid = Sandbox.start_owner!(Repo, shared: not tags[:async])
    on_exit(fn -> Sandbox.stop_owner(pid) end)
    {:ok, conn: ConnTest.build_conn()}
  end

  def log_in_athlete(conn, athlete) do
    conn
    |> ConnTest.init_test_session(%{})
    |> Conn.put_session(:athlete_uuid, athlete.uuid)
  end
end
