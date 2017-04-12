require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }


  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to validate_confirmation_of(:password) }
  it { is_expected.to allow_value('costa@nonato.com').for(:email) }
end