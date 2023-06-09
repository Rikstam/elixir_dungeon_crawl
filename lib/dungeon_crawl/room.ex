defmodule DungeonCrawl.Room do
  alias DungeonCrawl.Room
  alias DungeonCrawl.Room.Triggers

  import DungeonCrawl.Room.Action

  defstruct description: nil,
            actions: [],
            trigger: nil

  def all,
    do: [
      %Room{
        description: "You can see the light of day. You have found the exit!",
        actions: [
          forward()
        ],
        trigger: Triggers.Exit
      },
      %Room{
        description: "You see an enemy.",
        actions: [
          forward()
        ],
        trigger: Triggers.Enemy
      }
    ]
end
