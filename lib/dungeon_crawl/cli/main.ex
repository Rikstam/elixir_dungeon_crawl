defmodule DungeonCrawl.CLI.Main do
  alias Mix.Shell.IO, as: Shell

  def start_game do
    welcome_message()
    Shell.prompt("Press enter to continue")

    crawl(hero_choice(), DungeonCrawl.Room.all())
  end

  defp crawl(%{hit_points: 0}, _rooms) do
    Shell.prompt("")
    Shell.cmd("clear")
    Shell.info("You have died!")
    Shell.info("Game over!")
    Shell.prompt("")
  end

  defp crawl(character, rooms) do
    Shell.info("You keep moving toward the next room.")
    Shell.prompt("Press enter to continue")
    Shell.cmd("clear")

    Shell.info(DungeonCrawl.Character.current_stats(character))

    rooms
    |> Enum.random()
    |> DungeonCrawl.CLI.RoomActionsChoice.start()
    |> trigger_action(character)
    |> handle_action_result
  end

  defp welcome_message do
    Shell.info("== Welcome to Dungeon Crawl! ==")
    Shell.info("You awake in a dungeonfull of monsters.")
    Shell.info("You must  survive and find the exit to escape.")
  end

  defp hero_choice do
    hero = DungeonCrawl.CLI.HeroChoice.start()
    %{hero | name: "You"}
  end

  defp trigger_action({room, action}, character) do
    Shell.cmd("clear")
    room.trigger.run(character, action)
  end

  defp handle_action_result({_, :exit}) do
    Shell.info("You have escaped the dungeon!")
    Shell.info("You win!")
  end

  defp handle_action_result({character, _}), do: crawl(character, DungeonCrawl.Room.all())
end
