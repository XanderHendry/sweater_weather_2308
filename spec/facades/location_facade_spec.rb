require 'rails_helper'

RSpec.describe LocationFacade do
  describe 'Class Methods' do
    describe '#get_location_data' do
      it 'makes an external api call requesting location data for a given city, and returns the lat + lon', :vcr do
        location_data = LocationFacade.get_location_data('columbia,sc')
        expect(location_data).to be_a(Hash)
        expect(location_data).to have_key(:lat)
        expect(location_data[:lat]).to eq(33.99882)
        expect(location_data).to have_key(:lng)
        expect(location_data[:lng]).to eq(-81.04537)
      end
    end
  end
end 