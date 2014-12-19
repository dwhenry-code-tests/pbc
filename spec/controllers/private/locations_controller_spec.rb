require 'rails_helper'

describe Private::LocationsController, type: :controller do
  let(:country) { Country.create!(country_code: 'AUS') }
  let!(:location) do
    Location.create!(
      name: 'location',
      external_id: 'loc',
      secret_code: 'secret',
      country: country
    )
  end

  describe '#show' do
    it 'renders the appropriate locations json' do
      get :show, country_code: 'AUS', token: 'private'

      json = JSON.parse(response.body)
      expect(json).to eq(
        'locations' => [
          {
            'name' => 'location',
            'external_id' => 'loc',
            'secret_code' => 'secret',
          }
        ]
      )
    end
  end
end
