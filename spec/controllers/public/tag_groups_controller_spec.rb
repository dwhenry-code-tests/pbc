require 'rails_helper'

describe Public::TagGroupsController, type: :controller do
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

  describe '#show' do
    it 'renders the appropriate locations json' do
      get :show, country_code: 'AUS'

      json = JSON.parse(response.body)
      expect(json).to eq(
        'tag_groups' => [
          {
            'name' => 'root',
            'external_id' => 'root-external',
            'children' => [{
              'name' => 'child',
              'external_id' => 'child-external',
              'children' => []
            }]
          }
        ]
      )
    end
  end
end
