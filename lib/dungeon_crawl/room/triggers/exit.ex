defmodule DungeonCrawl.Room.Triggers.Exit do
  @behaviour DungeonCrawl.Room.Trigger
  @doc """
  It returns a tuple with the given hero and a flag saying that character has found the exit
  """
  def run(character, _), do: {character, :exit}
end
