require 'spec_helper'

describe Item do
  it { should have_and_belong_to_many :lists }
  it { should validate_uniqueness_of(:item_name) }
end
