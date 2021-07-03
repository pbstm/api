require 'rails_helper'

RSpec.describe PhotoSession, type: :model do
  subject { build :photo_session }

  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
  end

  describe 'associations' do
    it { should belong_to :location }
    it { should belong_to :photographer }
    it { should have_many( :photo_session_photos ).dependent :destroy }
  end
end
