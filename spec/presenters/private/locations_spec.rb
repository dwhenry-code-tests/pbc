require 'rails_helper'

describe Private::Locations do
  let(:country) { Country.create!(country_code: 'AUS') }
  let!(:location) do
    Location.create!(
      name: 'location',
      external_id: 'loc',
      secret_code: 'secret',
      country: country
    )
  end

  it 'creates a json object from showing private location fields' do
    expect(
      described_class.new('AUS').as_json
    ).to eq(locations: [{
      name: 'location',
      external_id: 'loc',
      secret_code: 'secret'
    }])
  end

  it 'does not include locations which are not for the specified country' do
    expect(
      described_class.new('NZL').as_json
    ).to eq(locations: [])
  end
end
