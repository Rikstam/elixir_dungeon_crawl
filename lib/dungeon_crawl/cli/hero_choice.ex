defmodule DungeonCrawl.CLI.HeroChoice do
  alias Mix.Shell.IO, as: Shell

  def start do
    Shell.cmd("clear")
    Shell.info("== Choose your hero ==")

    heroes = DungeonCrawl.Heroes.all()

    heroes
    |> Enum.map(& &1.name)
    |> display_options
  end

  defp display_options(options) do
    options
    |> Enum.with_index(1)
    |> Enum.each(fn {option, index} ->
      Shell.info("#{index} - #{option}")
    end)
  end
end
