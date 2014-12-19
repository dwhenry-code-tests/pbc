require 'rails_helper'

describe 'Specified Routing' do
  context 'public API' do
    it 'provides a GET location endpoint' do
      expect(get: '/locations/AUS').to route_to(
        controller: 'public/locations',
        action: 'show',
        country_code: 'AUS'
      )
    end

    it 'provides a GET tag_groups endpoint' do
      expect(get: '/tag_groups/AUS').to route_to(
        controller: 'public/tag_groups',
        action: 'show',
        country_code: 'AUS'
      )
    end

    it 'does not provide a POST evaluate_target endpoint' do
      expect(post: '/evaluate_target').not_to be_routable
    end
  end

  context 'private API' do
    context 'for valid auth token' do
      it 'provides a GET location endpoint' do
        expect(get: '/locations/AUS?token=private').to route_to(
          controller: 'private/locations',
          action: 'show',
          country_code: 'AUS',
          token: 'private'
        )
      end


      it 'provides a GET tag_groups endpoint' do
        expect(get: '/tag_groups/AUS?token=private').to route_to(
          controller: 'private/tag_groups',
          action: 'show',
          country_code: 'AUS',
          token: 'private'
        )
      end

      it 'provides a POST evaluate_target endpoint' do
        expect(post: '/evaluate_target?token=private').to route_to(
          controller: 'private/evaluate_target',
          action: 'create',
          token: 'private'
        )
      end
    end

    context 'for invalid auth token' do
      it 'relegates to the public GET location endpoint' do
        expect(get: '/locations/AUS?token=public').to route_to(
          controller: 'public/locations',
          action: 'show',
          country_code: 'AUS',
          token: 'public'
        )
      end

      it 'relegates to the public GET tag_groups endpoint'  do
        expect(get: '/tag_groups/AUS?token=public').to route_to(
          controller: 'public/tag_groups',
          action: 'show',
          country_code: 'AUS',
          token: 'public'
        )
      end

      it 'does not provide a POST evaluate_target endpoint' do
        expect(post: '/evaluate_target').not_to be_routable
      end
    end
  end
end
