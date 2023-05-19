defmodule DungeonCrawl.Room.Triggers.Enemy do
  alias Mix.Shell.IO, as: Shell
  @behaviour DungeonCrawl.Room.Trigger
  @doc """
  Take a ranfom enemy from the list of enemies and start a battle by passing
  the character and the enemy to DungeonCrawl.Battle.fight/2
  """
  def run(character, %DungeonCrawl.Room.Action{id: :forward}) do
    enemy = Enum.random(DungeonCrawl.Enemies.all())

    Shell.info("You encounter #{enemy.description}")
    Shell.info("The enemy #{enemy.name} wants to fight")
    Shell.info("You have #{character.hit_points} hit points")
    Shell.info("You are prepared to attack first")
    {updated_char, _enemy} = DungeonCrawl.Battle.fight(character, enemy)
    {updated_char, :forward}
  end
end
