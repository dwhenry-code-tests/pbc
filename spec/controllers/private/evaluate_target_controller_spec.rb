require 'rails_helper'

describe Private::EvaluateTargetController, type: :controller do
  let(:panel_provider) { PanelProvider.create!(code: 'alpha') }
  let(:country) { Country.create!(country_code: 'AUS', panel_provider: panel_provider) }
  let(:location) do
    Location.create!(
      name: 'location',
      external_id: 'loc',
      secret_code: 'secret',
      country: country
    )
  end

  let!(:target_group) do
    build_target_group('root', panel_provider: panel_provider)
  end

  describe '#create' do
    it 'delegates the params to the Pricer' do
      expect(Pricer).to receive(:new).with('AUS', '123', [{'id' => '234', 'panel_size' => '200'}]).and_return(double('Pricer', price: 2345))

      post :create, country_code: 'AUS', target_group_id: 123, locations: [{id: 234, panel_size: 200}], token: 'private'

      expect(response.body).to eq('2345')
    end

    it 'correctly calculates the price' do
      html = File.read(File.join(self.class.fixture_path, 'time.com'))

      stub_request(:get, 'http://time.com/').
        to_return(:status => 200, :body => html, :headers => {})

      post :create,
        country_code: country.country_code,
        target_group_id: target_group.id,
        locations: [{id: location.id, panel_size: 200}],
        token: 'private'

      expect(response.body).to eq('50.34')
    end
  end
end
