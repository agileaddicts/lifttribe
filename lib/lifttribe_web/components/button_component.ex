defmodule LifttribeWeb.Components.ButtonComponent do
  use Phoenix.Component

  def render(assigns) do
    ~H"""
    <button class="inline-flex items-center justify-center w-full px-4 py-2 text-sm font-semibold text-white rounded-full bg-orange group focus:outline-none focus-visible:outline-2 focus-visible:outline-offset-2 hover:text-slate-100 hover:bg-orange active:bg-orange active:text-orange focus-visible:outline-orange" type={@type}>
      <span><%= @text %></span>
    </button>
    """
  end
end
