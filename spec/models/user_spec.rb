require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email)}
    it { should validate_presence_of(:password) }
    it { should validate_confirmation_of(:password) }
  end

  describe 'callbacks' do
   describe 'before_create' do
     it 'generates API key on user creation' do
      user = build(:user)
      user.save
      expect(user.api_key).to be_present
     end
   end
  end
end
