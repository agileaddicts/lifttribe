defmodule LifttribeWeb.EarlyAccessRequestLive do
  use LifttribeWeb, :live_view

  alias Lifttribe.EarlyAccessRequest

  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       email: "",
       error: false,
       success: false
     )}
  end

  def handle_event("save", params, socket) do
    case params["email"] do
      "" ->
        {:noreply, socket}

      email ->
        case EarlyAccessRequest.create(email) do
          {:ok, _early_access_request} ->
            {:noreply,
             assign(socket,
               email: "",
               error: false,
               success: true
             )}

          {:error, _changeset} ->
            {:noreply,
             assign(socket,
               email: params["email"],
               error: true,
               success: false
             )}
        end
    end
  end
end
