defmodule DungeonCrawl.Room.Action do
  alias DungeonCrawl.Room.Action
  defstruct label: nil, id: nil

  def forward, do: %Action{id: :forward, label: "Go forward."}
  def rest, do: %Action{id: :rest, label: "Take a better look and Rest."}
  def search, do: %Action{id: :search, label: "Search the room."}
end
