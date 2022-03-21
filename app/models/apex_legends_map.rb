class ApexLegendsMap < ApplicationRecord
  validates :map_type, uniqueness: true

  enum :map_type, {
    current_battle_royale: 0,
    next_battle_royale: 1,
    current_arenas: 2,
    next_arenas: 3,
    current_ranked_arenas: 4,
    next_ranked_arenas: 5,
    current_ranked: 6,
    next_ranked: 7,
  }

  CURRENT_MAP_TYPES_WITH_TIMEFRAMES = [
    :current_battle_royale,
    :current_arenas,
    :current_ranked_arenas,
  ]

  def self.has_any_current_map_expired?
    where(map_type: CURRENT_MAP_TYPES_WITH_TIMEFRAMES)
      .where("ends_at < ?", DateTime.current)
      .count > 0
  end

  def self.current_battle_royale
    find_by(map_type: :current_battle_royale)
  end

  def self.next_battle_royale
    find_by(map_type: :next_battle_royale)
  end

  def self.current_arenas
    find_by(map_type: :current_arenas)
  end

  def self.next_arenas
    find_by(map_type: :next_arenas)
  end

  def self.current_ranked_arenas
    find_by(map_type: :current_ranked_arenas)
  end

  def self.next_ranked_arenas
    find_by(map_type: :next_ranked_arenas)
  end

  def self.current_ranked
    find_by(map_type: :current_ranked)
  end

  def self.next_ranked
    find_by(map_type: :next_ranked)
  end
end
