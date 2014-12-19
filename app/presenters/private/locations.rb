module Private
  class Locations < Shared::Locations
    def locations
      @locations.map do |location|
        {
          name: location.name,
          external_id: location.external_id,
          secret_code: location.secret_code
        }
      end
    end
  end
end
