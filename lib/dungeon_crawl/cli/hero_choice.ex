defmodule DungeonCrawl.CLI.HeroChoice do
  @moduledoc """
  This module is responsible for displaying the list of heroes and asking the user to choose one.
  """
  alias Mix.Shell.IO, as: Shell
  import DungeonCrawl.CLI.BaseCommands

  def start do
    Shell.cmd("clear")
    Shell.info("== Choose your hero ==")

    heroes = DungeonCrawl.Heroes.all()
    find_hero_by_index = &Enum.at(heroes, &1)

    heroes
    |> Enum.map(& &1.name)
    |> display_options
    |> generate_question
    |> Shell.prompt()
    |> parse_answer
    |> find_hero_by_index.()
    |> confirm_hero
  end

  @doc """
  In the confirm_hero/1 function we clear the screen, display the details of the chosen hero, and ask the user to confirm the choice.
  Windows users need to replace the clear command with cls to clear the screen.
  We use the yes?/1 function from Mix.Shell.IO to get the user input, check if it’s a positive answer, and parse it to a Boolean value.
  """
  defp confirm_hero(chosen_hero) do
    Shell.cmd("clear")
    Shell.info("You have chosen #{chosen_hero.description}")
    if Shell.yes?("Confirm"), do: chosen_hero, else: start()
  end
end
