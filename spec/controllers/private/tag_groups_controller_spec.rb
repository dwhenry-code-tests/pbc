require 'rails_helper'

describe Private::TagGroupsController, type: :controller do
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
      get :show, country_code: 'AUS', token: 'private'

      json = JSON.parse(response.body)
      expect(json).to eq(
        'tag_groups' => [
          {
            'name' => 'root',
            'external_id' => 'root-external',
            'secret_code' => 'root-secret',
            'children' => [{
              'name' => 'child',
              'external_id' => 'child-external',
              'secret_code' => 'child-secret',
              'children' => []
            }]
          }
        ]
      )
    end
  end
end
