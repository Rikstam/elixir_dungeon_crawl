defmodule DungeonCrawl.CLI.BaseCommands do
  alias Mix.Shell.IO, as: Shell

  def ask_for_index(options) do
    answer =
      options
      |> display_options()
      |> generate_question()
      |> Shell.prompt
      |> Integer.parse

    case answer do
      :error ->
        display_invalid_option()
        ask_for_index(options)
        {option, _} -> option - 1
    end
  end

  defp display_invalid_option do
    Shell.cmd("clear")
    Shell.prompt"Invalid option, please press Enter to  try again")
    Shell.cmd("clear")
  end

  def ask_for_option(options) do
    index = ask_for_index(options)
    chosen_option = Enum.at(options, index)
    chosen_option
      || (display_invalid_option() && ask_for_option(options))
  end


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
