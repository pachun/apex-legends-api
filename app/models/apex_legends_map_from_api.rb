class ApexLegendsMapFromApi
  attr_accessor :map_type, :name, :epoch_start_time, :epoch_end_time

  def initialize(args = {})
    @map_type = args[:map_type]
    @name = args[:name]
    @epoch_start_time = args[:epoch_start_time]
    @epoch_end_time = args[:epoch_end_time]
  end

  def save
    if has_timeframe?
      ApexLegendsMap
        .find_or_create_by(map_type: map_type.to_sym)
        .update(
          name: fixed_map_name,
          starts_at: DateTime.strptime(epoch_start_time.to_s, "%s"),
          ends_at: DateTime.strptime(epoch_end_time.to_s, "%s"),
        )
    else
      ApexLegendsMap
        .find_or_create_by(map_type: map_type.to_sym)
        .update(name: name)
    end
  end

  private

  MAP_TYPES_WITHOUT_TIMEFRAMES = ["current_ranked", "next_ranked"]

  def has_timeframe?
    !MAP_TYPES_WITHOUT_TIMEFRAMES.include?(map_type)
  end

  def fixed_map_name
    if name === "Habitat"
      "Habitat 4"
    else
      name.titleize
    end
  end
end
