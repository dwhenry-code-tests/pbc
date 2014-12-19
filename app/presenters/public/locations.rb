module Public
  class Locations
    def initialize(country_code)
      @locations = Location.
        includes(:country).
        where(countries: { country_code: country_code })
    end

    def as_json(opts=nil)
      {
        locations: locations
      }
    end

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
