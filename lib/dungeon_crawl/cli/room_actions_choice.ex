defmodule DungeonCrawl.CLI.RoomActionsChoice do
  alias Mix.Shell.IO, as: Shell
  import DungeonCrawl.CLI.BaseCommands

  def start(room) do
    room_actions = room.actions
    find_action_by_index = &Enum.at(room_actions, &1)

    Shell.info(room.description)

    chosen_action = ask_for_option(room_actions)

    {room, chosen_action}
  end
end
