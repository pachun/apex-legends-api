class GetApexLegendsMapsFromApiService
  API_ENDPOINT = "https://api.mozambiquehe.re/maprotation?version=2&auth=#{
    Rails.application.credentials.apex_legends_api_key
  }"

  def self.get
    new.get
  end

  def get
    [
      current_battle_royale,
      next_battle_royale,
      current_arenas,
      next_arenas,
      current_ranked_arenas,
      next_ranked_arenas,
      current_ranked,
      next_ranked,
    ]
  end

  private

  def api_response
    @api_response ||= Faraday.get(API_ENDPOINT)
  end

  def api_response_json
    @api_response_json ||= JSON.parse(api_response.body)
  end

  def current_battle_royale
    ApexLegendsMapFromApi.new(
      map_type: "current_battle_royale",
      name: api_response_json["battle_royale"]["current"]["map"],
      epoch_start_time: api_response_json["battle_royale"]["current"]["start"],
      epoch_end_time: api_response_json["battle_royale"]["current"]["end"],
    )
  end

  def next_battle_royale
    ApexLegendsMapFromApi.new(
      map_type: "next_battle_royale",
      name: api_response_json["battle_royale"]["next"]["map"],
      epoch_start_time: api_response_json["battle_royale"]["next"]["start"],
      epoch_end_time: api_response_json["battle_royale"]["next"]["end"],
    )
  end

  def current_arenas
    ApexLegendsMapFromApi.new(
      map_type: "current_arenas",
      name: api_response_json["arenas"]["current"]["map"],
      epoch_start_time: api_response_json["arenas"]["current"]["start"],
      epoch_end_time: api_response_json["arenas"]["current"]["end"],
    )
  end

  def next_arenas
    ApexLegendsMapFromApi.new(
      map_type: "next_arenas",
      name: api_response_json["arenas"]["next"]["map"],
      epoch_start_time: api_response_json["arenas"]["next"]["start"],
      epoch_end_time: api_response_json["arenas"]["next"]["end"],
    )
  end

  def current_ranked_arenas
    ApexLegendsMapFromApi.new(
      map_type: "current_ranked_arenas",
      name: api_response_json["arenasRanked"]["current"]["map"],
      epoch_start_time: api_response_json["arenasRanked"]["current"]["start"],
      epoch_end_time: api_response_json["arenasRanked"]["current"]["end"],
    )
  end

  def next_ranked_arenas
    ApexLegendsMapFromApi.new(
      map_type: "next_ranked_arenas",
      name: api_response_json["arenasRanked"]["next"]["map"],
      epoch_start_time: api_response_json["arenasRanked"]["next"]["start"],
      epoch_end_time: api_response_json["arenasRanked"]["next"]["end"],
    )
  end

  def current_ranked
    ApexLegendsMapFromApi.new(
      map_type: "current_ranked",
      name: api_response_json["ranked"]["current"]["map"],
    )
  end

  def next_ranked
    ApexLegendsMapFromApi.new(
      map_type: "next_ranked",
      name: api_response_json["ranked"]["next"]["map"],
    )
  end
end
