require 'rails_helper'

describe Public::LocationsController, type: :controller do
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
      get :show, country_code: 'AUS'

      json = JSON.parse(response.body)
      expect(json).to eq(
        'locations' => [
          {
            'name' => 'location',
            'external_id' => 'loc',
          }
        ]
      )
    end
  end
end
