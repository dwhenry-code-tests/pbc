module Shared
  class TagGroups
    # TODO: add code to limit the number of levels the
    #       code can output, with a user settable parameter
    #       to increase if required
    def initialize(country_code)
      @panel_provider = PanelProvider.
        includes(:countries, :target_groups).
        find_by(countries: {country_code: country_code})
    end

    def as_json(opts=nil)
      {
        tag_groups: tag_groups_for(root_target_groups)
      }
    end

    private

    def tag_groups_for(target_groups)
      raise 'Implement in subclass'
    end

    def root_target_groups
      return [] unless @panel_provider
      @panel_provider.
        target_groups.
        where(parent_id: nil)
    end
  end
end
