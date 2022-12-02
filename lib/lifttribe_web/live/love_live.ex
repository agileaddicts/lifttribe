defmodule LifttribeWeb.LoveLive do
  use Phoenix.LiveView

  def render(assigns) do
    ~H"""
      <h1 class="pb-8 font-serif text-4xl font-bold text-center text-orange">Love is Love</h1>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
