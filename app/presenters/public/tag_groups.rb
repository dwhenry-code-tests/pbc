module Public
  class TagGroups < Shared::TagGroups
    private

    def tag_groups_for(target_groups)
      target_groups.map do |target_group|
        {
          name: target_group.name,
          external_id: target_group.external_id,
          children: tag_groups_for(target_group.children)
        }
      end
    end
  end
end
