class ApexLegendsMapsController < ApplicationController
  def index
    update_apex_legends_maps if should_update_apex_legends_maps?

    render json: ApexLegendsMap.all
  end

  private

  def update_apex_legends_maps
    UpdateApexLegendsMaps.update
  end

  def should_update_apex_legends_maps?
    # keep the 0 check second for fewer database queries most of the time
    ApexLegendsMap.has_any_current_map_expired? ||
      ApexLegendsMap.all.count == 0
  end
end
