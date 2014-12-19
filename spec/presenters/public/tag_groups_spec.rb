require 'rails_helper'

describe Public::TagGroups do
  let(:panel_provider) { PanelProvider.create!(code: 'alpha') }
  let!(:country) { Country.create!(country_code: 'AUS', panel_provider: panel_provider) }

  let!(:parent_target_group) do
    build_target_group('root', panel_provider: panel_provider)
  end
  let!(:child_target_group) do
    build_target_group(
      'child',
      panel_provider: panel_provider,
      parent: parent_target_group)
  end
  let!(:grandchild_target_group) do
    build_target_group(
      'grandchild',
      panel_provider: panel_provider,
      parent: child_target_group)
  end

  it 'creates a json object from showing private tag_group fields' do
    expect(
      described_class.new('AUS').as_json
    ).to eq(tag_groups: [
      {
        name: 'root',
        external_id: 'root-external',
        children: [{
          name: 'child',
          external_id: 'child-external',
          children: [{
            name: 'grandchild',
            external_id: 'grandchild-external',
            children: []
          }]
        }]
      }
    ]
    )
  end

  it 'does not include locations which are not for the specified country' do
    expect(
      described_class.new('NZL').as_json
    ).to eq(tag_groups: [])
  end

end
