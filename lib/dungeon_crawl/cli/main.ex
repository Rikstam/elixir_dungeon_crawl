defmodule DungeonCrawl.CLI.Main do
  alias Mix.Shell.IO, as: Shell

  def start_game do
    welcome_message()
    Shell.prompt("Press enter to continue")
    hero_choice()
    crawl(DungeonCrawl.Room.all())
  end

  defp crawl(rooms) do
    Shell.info("You keep moving toward the next room.")
    Shell.prompt("Press enter to continue")
    Shell.cmd("clear")

    rooms
    |> Enum.random()
    |> DungeonCrawl.CLI.RoomActionsChoice.start()
  end

  defp welcome_message do
    Shell.info("== Welcome to Dungeon Crawl! ==")
    Shell.info("You awake in a dungeonfull of monsters.")
    Shell.info("You must  survive and find the exit to escape.")
  end

  defp hero_choice do
    DungeonCrawl.CLI.HeroChoice.start()
  end
end
