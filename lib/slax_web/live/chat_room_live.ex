defmodule SlaxWeb.ChatRoomLive do
  use SlaxWeb, :live_view

  alias Slax.Repo
  alias Slax.Chat.Room

  def mount(_params, _session, socket) do
    room = Room |> Repo.all() |> List.first()

    {:ok,
     socket
     |> assign(:room, room)
     |> assign(hide_topic?: false)}
  end

  def render(assigns) do
    ~H"""
    <div class="flex flex-col grow shadow-lg">
      <div class="flex justify-between items-center shrink-0 h-16 bg-white border-b border-slate-300 px-4">
        <div class="flex flex-col gap-1.5">
          <h1 class="text-sm font-bold leading-none">
            #{@room.name}
          </h1>
          <div
            class={["text-xs leading-none h-3.5 cursor-default select-none", @hide_topic? && "text-slate-600"]}
            phx-click="toggle_topic"
          >
            <%= if @hide_topic? do %>
              [Topic hidden]
            <% else %>
              {@room.topic}
            <% end %>
          </div>
        </div>
      </div>
    </div>
    """
  end

  def handle_event("toggle_topic", _params, socket) do
    {:noreply, socket |> assign(:hide_topic?, !socket.assigns.hide_topic?)}
  end
end
