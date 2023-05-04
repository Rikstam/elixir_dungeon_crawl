defprotocol DungeonCrawl.Display do
  def info(value)
end

defimpl DungeonCrawl.Display, for: DungeonCrawl.Room.Action do
  def info(action), do: action.label
end

defimpl DungeonCrawl.Display, for: DungeonCrawl.Room.Character do
  def info(character), do: character.name
end
