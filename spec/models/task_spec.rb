require 'rails_helper'

describe Task, type: :model do
  context "assocations" do
    it { should belong_to(:user) }
  end

  context "description validation" do
    it { should validate_presence_of(:description) }
  end
end
