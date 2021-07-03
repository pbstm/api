require 'rails_helper'

RSpec.describe PhotoSessionPhoto, type: :model do
  subject { build :photo_session_photo }

  describe 'validations' do
    it { should validate_presence_of :photo }
  end

  describe 'associations' do
    it { should belong_to :photo_session }
  end
end
