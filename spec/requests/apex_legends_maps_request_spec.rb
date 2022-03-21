require "rails_helper"

describe "/apex_legends_maps" do
  describe "GET requests" do
    context "current maps exist and one or more have expired" do
      it "refetches the maps" do
        create :apex_legends_map,
          map_type: "current_battle_royale"

        allow(ApexLegendsMap)
          .to(receive(:has_any_current_map_expired?))
          .and_return(true)

        allow(UpdateApexLegendsMaps).to receive(:update)

        get "/apex_legends_maps"

        expect(UpdateApexLegendsMaps).to have_received(:update)
      end
    end

    context "current maps exist and none have expired" do
      it "does not refetch the maps" do
        create :apex_legends_map,
          map_type: "current_battle_royale"

        allow(ApexLegendsMap)
          .to(receive(:has_any_current_map_expired?))
          .and_return(false)

        allow(UpdateApexLegendsMaps).to receive(:update)

        get "/apex_legends_maps"

        expect(UpdateApexLegendsMaps).not_to have_received(:update)
      end
    end

    context "no maps exist in the database" do
      it "gets the current maps and returns them" do
        expect(ApexLegendsMap.all.length).to eq(0)

        VCR.use_cassette("maps_on_3_21_2022_at_6_15_pm_est") do
          allow(UpdateApexLegendsMaps).to receive(:update).and_call_original

          get "/apex_legends_maps"

          expect(UpdateApexLegendsMaps).to have_received(:update)
          expect(JSON.parse(response.body)).to match_array([{
            "map_type" => "current_battle_royale",
            "name" => "Olympus",
            "starts_at" => DateTime.strptime("1647898200", "%s").utc.iso8601,
            "ends_at" => DateTime.strptime("1647905400", "%s").utc.iso8601,
          }, {
            "map_type" => "next_battle_royale",
            "name" => "Kings Canyon",
            "starts_at" => DateTime.strptime("1647905400", "%s").utc.iso8601,
            "ends_at" => DateTime.strptime("1647912600", "%s").utc.iso8601,
          }, {
            "map_type" => "current_arenas",
            "name" => "Phase Runner",
            "starts_at" => DateTime.strptime("1647900900", "%s").utc.iso8601,
            "ends_at" => DateTime.strptime("1647901800", "%s").utc.iso8601,
          }, {
            "map_type" => "next_arenas",
            "name" => "Habitat 4",
            "starts_at" => DateTime.strptime("1647901800", "%s").utc.iso8601,
            "ends_at" => DateTime.strptime("1647902700", "%s").utc.iso8601,
          }, {
            "map_type" => "current_ranked_arenas",
            "name" => "Phase Runner",
            "starts_at" => DateTime.strptime("1647900000", "%s").utc.iso8601,
            "ends_at" => DateTime.strptime("1647902400", "%s").utc.iso8601,
          }, {
            "map_type" => "next_ranked_arenas",
            "name" => "Overflow",
            "starts_at" => DateTime.strptime("1647902400", "%s").utc.iso8601,
            "ends_at" => DateTime.strptime("1647904800", "%s").utc.iso8601,
          }, {
            "map_type" => "current_ranked",
            "name" => "Olympus",
            "starts_at" => nil,
            "ends_at" => nil,
          }, {
            "map_type" => "next_ranked",
            "name" => "Kings Canyon",
            "starts_at" => nil,
            "ends_at" => nil,
          }])
        end
      end
    end
  end
end
