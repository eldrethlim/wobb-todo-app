require 'rails_helper'

describe User, type: :model do
  let(:user) { create(:user) }

  context "assocations" do
    it { should have_many(:tasks) }
  end

  context "email validation" do
    it { should validate_presence_of(:email).with_message('is invalid') }
    it { should validate_uniqueness_of(:email).with_message('has already been taken.') }
    it { should allow_value("test@email.com").for(:email) }
  end

  context "password validation" do
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(5) }
    it { should validate_confirmation_of(:password) }
    it { should have_secure_password }
  end

  context "name validation" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  it 'authenticates user' do
    authenticated_user = User.find_by_credentials(user.email, "password")
    expect(authenticated_user.id).to eql(user.id)
    expect(authenticated_user.email).to eql(user.email)
  end
end
