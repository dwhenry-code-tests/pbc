require 'rails_helper'
require 'pricer'

describe Pricer do
  let!(:country) { Country.create(country_code: 'AUS', panel_provider: panel_provider) }
  subject { described_class.new(country.country_code, '123', [{'id' => '234', 'panel_size' => '100'}]) }

  context 'For panel alpha - Panel 1' do
    let(:panel_provider) { PanelProvider.create(code: 'alpha') }
    before do
      allow(Net::HTTP).to receive(:get).and_return('<html>one letter a, two letter a<html>')
    end

    it 'price is set to count of letter `a` on http://time.com' do
      expect(subject.price).to eq(0.02)
    end
  end

  context 'For panel beta - Panel 2' do
    let(:panel_provider) { PanelProvider.create(code: 'beta') }

    it 'price is set to count of `<b>` stirng in google search results' do
      allow(Net::HTTP).to receive(:get).and_return('some things are <b>more</b> and some things are <b>less</b> important than <b>others</b><html>')
      expect(subject.price).to eq(3.0)
    end

    it 'can handle start of string edge cases' do
      allow(Net::HTTP).to receive(:get).and_return('<b>more</b> and some things are <b>less</b> important than <b>aa')
      expect(subject.price).to eq(3.0)
    end

    it 'can handle end of string edge cases' do
      allow(Net::HTTP).to receive(:get).and_return('aaa<b>more</b> and some things are <b>less</b> important than <b>')
      expect(subject.price).to eq(3.0)
    end
  end

  context 'For panel gamma - Panel 3' do
    let(:panel_provider) { PanelProvider.create(code: 'gamma') }

    it 'price is set to count of nowa on http://time.com' do
      allow(Net::HTTP).to receive(:get).and_return('<html><body>some things are <b>more</b> and some things are <b>less</b> important than <b>others</b></body></html>')
      expect(subject.price).to eq(0.05)
    end
  end

  context 'for any other uniplemented panel provider' do
    let(:panel_provider) { PanelProvider.create(code: 'other') }

    it 'raise and UnknownPricingPolicy error' do

      expect { subject.price}.to raise_error(Pricer::UnknownPricingPolicy, 'other')
    end

  end
end
