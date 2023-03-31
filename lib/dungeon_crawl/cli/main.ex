defmodule DungeonCrawl.CLI.Main do
  alias Mix.Shell.IO, as: Shell

  def start_game do
    welcome_message()
  end

  defp welcome_message do
    Shell.info("== Welcome to Dungeon Crawl! ==")
    Shell.info("You awake in a dungeonfull of monsters.")
    Shell.info("You must  survive and find the exit to escape.")
  end
end
