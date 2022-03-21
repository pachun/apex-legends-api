class UpdateApexLegendsMaps
  def self.update
    new.update
  end

  def update
    apex_legends_maps_from_api.each do |apex_legend_map_from_api|
      apex_legend_map_from_api.save
    end
  end

  private

  def apex_legends_maps_from_api
    @apex_legends_maps_from_api ||= GetApexLegendsMapsFromApiService.get
  end
end
