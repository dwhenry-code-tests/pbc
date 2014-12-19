module Shared
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
      raise 'Implement in subclass'
    end
  end
end
