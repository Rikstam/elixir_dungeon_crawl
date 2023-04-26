defmodule DungeonCrawl.CLI.BaseCommands do
  alias Mix.Shell.IO, as: Shell

  def display_options(options) do
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
  def generate_question(options) do
    options = Enum.join(1..Enum.count(options), ", ")
    "Choose one of the following options: [#{options}] \n"
  end

  @doc """
  Tries to parse an integer from the user input, then subtracts one to get the index of the hero
  """
  def parse_answer(answer) do
    {option, _} = Integer.parse(answer)
    option - 1
  end
end
