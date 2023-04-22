defmodule DungeonCrawl.Room do
  alias DungeonCrawl.Room

  defstruct description: nil,
            actions: []

  def all,
    do: [
      %Room{
        description: "You found a quiet place. Looks safe to rest.",
        actions: [
          [forward(), rest()]
        ]
      }
    ]
end
