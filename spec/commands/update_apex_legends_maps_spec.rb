require "rails_helper"

describe UpdateApexLegendsMaps do
  describe "self.update" do
    it "updates apex legends maps in postgres" do
      map_types = [
        "current_battle_royale",
        "next_battle_royale",
        "current_ranked",
        "next_ranked",
        "current_arenas",
        "next_arenas",
        "current_ranked_arenas",
        "next_ranked_arenas",
      ]
      existing_maps = map_types.map do |map_type|
        create :apex_legends_map, map_type: map_type
      end

      allow(GetApexLegendsMapsFromApiService).to receive(:get).and_return([
        ApexLegendsMapFromApi.new(
          map_type: "current_battle_royale",
          name: "Olympus",
          epoch_start_time: 1647898200,
          epoch_end_time: 1647905400,
        ),
        ApexLegendsMapFromApi.new(
          map_type: "next_battle_royale",
          name: "Kings Canyon",
          epoch_start_time: 1647905400,
          epoch_end_time: 1647912600,
        ),
        ApexLegendsMapFromApi.new(
          map_type: "current_arenas",
          name: "Phase runner",
          epoch_start_time: 1647900900,
          epoch_end_time: 1647901800,
        ),
        ApexLegendsMapFromApi.new(
          map_type: "next_arenas",
          name: "Overflow",
          epoch_start_time: 1647901800,
          epoch_end_time: 1647902700,
        ),
        ApexLegendsMapFromApi.new(
          map_type: "current_ranked_arenas",
          name: "Phase runner",
          epoch_start_time: 1647900000,
          epoch_end_time: 1647902400,
        ),
        ApexLegendsMapFromApi.new(
          map_type: "next_ranked_arenas",
          name: "Overflow",
          epoch_start_time: 1647902400,
          epoch_end_time: 1647904800,
        ),
        ApexLegendsMapFromApi.new(
          map_type: "current_ranked",
          name: "Olympus",
        ),
        ApexLegendsMapFromApi.new(
          map_type: "next_ranked",
          name: "Kings Canyon",
        ),
      ])

      UpdateApexLegendsMaps.update

      expect(ApexLegendsMap.all.count).to eq(map_types.length)

      expect(ApexLegendsMap.current_battle_royale).to have_attributes(
        name: "Olympus",
        starts_at: DateTime.strptime("1647898200", "%s"),
        ends_at: DateTime.strptime("1647905400", "%s"),
      )
      expect(ApexLegendsMap.next_battle_royale).to have_attributes(
        name: "Kings Canyon",
        starts_at: DateTime.strptime("1647905400", "%s"),
        ends_at: DateTime.strptime("1647912600", "%s"),
      )
      expect(ApexLegendsMap.current_arenas).to have_attributes(
        name: "Phase Runner",
        starts_at: DateTime.strptime("1647900900", "%s"),
        ends_at: DateTime.strptime("1647901800", "%s"),
      )
      expect(ApexLegendsMap.next_arenas).to have_attributes(
        name: "Overflow",
        starts_at: DateTime.strptime("1647901800", "%s"),
        ends_at: DateTime.strptime("1647902700", "%s"),
      )
      expect(ApexLegendsMap.current_ranked_arenas).to have_attributes(
        name: "Phase Runner",
        starts_at: DateTime.strptime("1647900000", "%s"),
        ends_at: DateTime.strptime("1647902400", "%s"),
      )
      expect(ApexLegendsMap.next_ranked_arenas).to have_attributes(
        name: "Overflow",
        starts_at: DateTime.strptime("1647902400", "%s"),
        ends_at: DateTime.strptime("1647904800", "%s"),
      )
      expect(ApexLegendsMap.current_ranked).to have_attributes(
        name: "Olympus",
      )
      expect(ApexLegendsMap.next_ranked).to have_attributes(
        name: "Kings Canyon",
      )
    end
  end
end
