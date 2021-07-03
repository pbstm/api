require 'rails_helper'

RSpec.describe Location, type: :model do
  subject { build :location }

  describe 'validations' do
    it { should validate_presence_of :city }
  end

  describe 'associations' do
    it { should have_one( :photo_session ) }
  end
end
