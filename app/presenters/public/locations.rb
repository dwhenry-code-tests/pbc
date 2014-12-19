module Public
  class Locations < Shared::Locations
    def locations
      @locations.map do |location|
        {
          name: location.name,
          external_id: location.external_id,
        }
      end
    end
  end
end
