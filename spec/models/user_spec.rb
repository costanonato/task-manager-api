require 'rails_helper'

RSpec.describe User, type: :model do
  before { @user = FactoryGirl.build(:user) }

  it { expect(@user).to respond_to(:email) }
  it { expect(@user).to respond_to(:name) }
  it { expect(@user).to respond_to(:password) }
  it { expect(@user).to respond_to(:password_confirmation) }
  it { expect(@user).to be_valid }
end
