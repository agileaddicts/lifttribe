defmodule LifttribeWeb.Components.ButtonComponent do
  use Phoenix.Component

  def render(assigns) do
    ~H"""
    <button class="inline-flex items-center justify-center w-full px-4 py-2 text-sm font-semibold text-white rounded-full bg-orange group  hover:text-slate-100 hover:opacity-80" type={@type}>
      <span><%= @text %></span>
    </button>
    """
  end
end
