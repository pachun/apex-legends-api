require "rails_helper"

describe GetApexLegendsMapsFromApiService do
  describe "self.get" do

    def attributes_for_map_type_in_vcr(map_type)
      case map_type
      when :current_battle_royale
        {
          name: "Olympus",
          epoch_start_time: 1647898200,
          epoch_end_time: 1647905400,
        }
      when :next_battle_royale
        {
          name: "Kings Canyon",
          epoch_start_time: 1647905400,
          epoch_end_time: 1647912600,
        }
      when :current_arenas
        {
          name: "Phase runner",
          epoch_start_time: 1647900900,
          epoch_end_time: 1647901800,
        }
      when :next_arenas
        {
          name: "Habitat",
          epoch_start_time: 1647901800,
          epoch_end_time: 1647902700,
        }
      when :current_ranked_arenas
        {
          name: "Phase runner",
          epoch_start_time: 1647900000,
          epoch_end_time: 1647902400,
        }
      when :next_ranked_arenas
        {
          name: "Overflow",
          epoch_start_time: 1647902400,
          epoch_end_time: 1647904800,
        }
      when :current_ranked
        {
          name: "Olympus",
        }
      when :next_ranked
        {
          name: "Kings Canyon",
        }
      end
    end

    it "returns the current battle royale map rotation" do
      VCR.use_cassette("maps_on_3_21_2022_at_6_15_pm_est") do
        maps_from_api = GetApexLegendsMapsFromApiService.get

        expected_map_types = [
          :current_battle_royale,
          :next_battle_royale,
          :current_arenas,
          :next_arenas,
          :current_ranked_arenas,
          :next_ranked_arenas,
          :current_ranked,
          :next_ranked,
        ]

        expect(maps_from_api.length).to eq(expected_map_types.length)
        expect(maps_from_api.map(&:class).uniq).to eq([ApexLegendsMapFromApi])

        expected_map_types.each do |expected_map_type|
          map_from_api = maps_from_api.detect do |map_from_api|
            map_from_api.map_type.to_sym == expected_map_type
          end
          expected_attributes = attributes_for_map_type_in_vcr(expected_map_type)

          expect(map_from_api).to have_attributes(expected_attributes)
        end
      end
    end
  end
end
