require 'rails_helper'

describe AuthTokenService do
  describe "encode data" do
    let(:user) { create(:user) }

    it "should encode/decode data" do
      payload = { user_id: user.id }
      token = AuthTokenService.encode(payload)
      expect(token).to be_truthy

      data = AuthTokenService.decode(token)
      expect(data["user_id"]).to eql(user.id)
    end
  end
end
