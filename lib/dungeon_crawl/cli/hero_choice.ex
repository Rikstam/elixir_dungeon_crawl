defmodule DungeonCrawl.CLI.HeroChoice do
  alias Mix.Shell.IO, as: Shell

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

  defp display_options(options) do
    options
    |> Enum.with_index(1)
    |> Enum.each(fn {option, index} ->
      Shell.info("#{index} - #{option}")
    end)

    options
  end

  @doc """
  It starts generating a string by building a range from 1 to the number of elements and joins them with a comma, generating something like "1,2,3".
  It joins the question and the numbers and returns the result.
  """
  defp generate_question(options) do
    options = Enum.join(1..Enum.count(options), ", ")
    "Choose one of the following options: [#{options}] \n"
  end

  @doc """
  Tries to parse an integer from the user input, then subtracts one to get the index of the hero
  """
  defp parse_answer(answer) do
    {option, _} = Integer.parse(answer)
    option - 1
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
