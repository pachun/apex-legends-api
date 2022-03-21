require 'rails_helper'

RSpec.describe ApexLegendsMap, type: :model do
  it { should validate_uniqueness_of(:map_type).ignoring_case_sensitivity }

  describe "self.has_any_current_map_expired?" do
    context "none of the current maps (which have end times) have expired" do
      it "returns false" do
        create :apex_legends_map,
          map_type: "current_battle_royale",
          ends_at: 5.minutes.from_now

        create :apex_legends_map,
          map_type: "current_ranked"

        create :apex_legends_map,
          map_type: "current_arenas",
          ends_at: 10.minutes.from_now

        create :apex_legends_map,
          map_type: "current_ranked_arenas",
          ends_at: 20.minutes.from_now

        expect(ApexLegendsMap.has_any_current_map_expired?).to be(false)
      end
    end

    context "the current battle royale map has expired" do
      it "returns true" do
        create :apex_legends_map,
          map_type: "current_battle_royale",
          ends_at: 5.minutes.ago

        create :apex_legends_map,
          map_type: "current_ranked"

        create :apex_legends_map,
          map_type: "current_arenas",
          ends_at: 10.minutes.from_now

        create :apex_legends_map,
          map_type: "current_ranked_arenas",
          ends_at: 20.minutes.from_now

        expect(ApexLegendsMap.has_any_current_map_expired?).to be(true)
      end
    end

    context "the current arenas map has expired" do
      it "returns true" do
        create :apex_legends_map,
          map_type: "current_battle_royale",
          ends_at: 5.minutes.from_now

        create :apex_legends_map,
          map_type: "current_ranked"

        create :apex_legends_map,
          map_type: "current_arenas",
          ends_at: 10.minutes.ago

        create :apex_legends_map,
          map_type: "current_ranked_arenas",
          ends_at: 20.minutes.from_now

        expect(ApexLegendsMap.has_any_current_map_expired?).to be(true)
      end
    end

    context "the current ranked arenas map has expired" do
      it "returns true" do
        create :apex_legends_map,
          map_type: "current_battle_royale",
          ends_at: 5.minutes.from_now

        create :apex_legends_map,
          map_type: "current_ranked"

        create :apex_legends_map,
          map_type: "current_arenas",
          ends_at: 10.minutes.from_now

        create :apex_legends_map,
          map_type: "current_ranked_arenas",
          ends_at: 20.minutes.ago

        expect(ApexLegendsMap.has_any_current_map_expired?).to be(true)
      end
    end
  end

  describe "self.current_battle_royale" do
    it "returns the current battle royale map" do
      current_battle_royale = create :apex_legends_map,
        map_type: :current_battle_royale

      expect(ApexLegendsMap.current_battle_royale).to eq(current_battle_royale)
    end
  end

  describe "self.next_battle_royale" do
    it "returns the next battle royale map" do
      next_battle_royale = create :apex_legends_map,
        map_type: :next_battle_royale

      expect(ApexLegendsMap.next_battle_royale).to eq(next_battle_royale)
    end
  end

  describe "self.current_arenas" do
    it "returns the current arenas map" do
      current_arenas = create :apex_legends_map,
        map_type: :current_arenas

      expect(ApexLegendsMap.current_arenas).to eq(current_arenas)
    end
  end

  describe "self.next_arenas" do
    it "returns the next arenas map" do
      next_arenas = create :apex_legends_map,
        map_type: :next_arenas

      expect(ApexLegendsMap.next_arenas).to eq(next_arenas)
    end
  end

  describe "self.current_ranked_arenas" do
    it "returns the current ranked arenas map" do
      current_ranked_arenas = create :apex_legends_map,
        map_type: :current_ranked_arenas

      expect(ApexLegendsMap.current_ranked_arenas).to eq(current_ranked_arenas)
    end
  end

  describe "self.next_ranked_arenas" do
    it "returns the next ranked arenas map" do
      next_ranked_arenas = create :apex_legends_map,
        map_type: :next_ranked_arenas

      expect(ApexLegendsMap.next_ranked_arenas).to eq(next_ranked_arenas)
    end
  end

  describe "self.current_ranked" do
    it "returns the current ranked map" do
      current_ranked = create :apex_legends_map,
        map_type: :current_ranked

      expect(ApexLegendsMap.current_ranked).to eq(current_ranked)
    end
  end

  describe "self.next_ranked" do
    it "returns the next ranked map" do
      next_ranked = create :apex_legends_map,
        map_type: :next_ranked

      expect(ApexLegendsMap.next_ranked).to eq(next_ranked)
    end
  end
end
