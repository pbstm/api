require 'rails_helper'

RSpec.describe Photographer, type: :model do
  subject { build :photographer }

  describe 'associations' do
    it { should have_many( :photo_sessions ).dependent :destroy }
  end
end
