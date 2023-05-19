defmodule DungeonCrawl.Battle do
  alias DungeonCrawl.Character
  alias Mix.Shell.IO, as: Shell

  @doc """
  check if one of the characters has zero hit points.
  If yes, the battle is over and the function returns a tuple
  with the characters in the same order as the given arguments
  """
  def fight(
        char_a = %{hit_points: hit_points_a},
        char_b = %{hit_points: hit_points_b}
      )
      when hit_points_a == 0 or hit_points_b == 0,
      do: {char_a, char_b}

  def fight(char_a, char_b) do
    char_b_after_damage = attack(char_a, char_b)
    char_a_after_damage = attack(char_b_after_damage, char_a)
    fight(char_a_after_damage, char_b_after_damage)
  end

  @doc """
  Checks if the attacker has zero hit points; if so, nothing happens to the attacked characte
  """
  defp attack(%{hit_points: hit_points_a}, character_b) when hit_points_a == 0, do: character_b

  @doc """
  Else the attacked character receives a random amount of damage from the attacker’s damage range
  """
  defp attack(character_a, character_b) do
    damage = Enum.random(character_a.damage_range)
    character_b_after_damage = Character.take_damage(character_b, damage)

    character_a
    |> attack_message(damage)
    |> Shell.info()

    character_b_after_damage
    |> receive_message(damage)
    |> Shell.info()

    character_b_after_damage
  end

  defp attack_message(character = %{name: "You"}, damage) do
    "#{character.name} attack with #{character.attack_description} for #{damage} damage"
  end

  defp attack_message(character, damage) do
    "#{character.name} attacks with #{character.attack_description} for #{damage} damage"
  end

  defp receive_message(character = %{name: "You"}, damage) do
    "#{character.name} receive #{damage} damage. Current hitpoints: #{character.hit_points}"
  end

  defp receive_message(character, damage) do
    "#{character.name} receives #{damage} damage. Current hitpoints: #{character.hit_points}"
  end
end
