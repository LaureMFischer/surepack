require 'spec_helper'

describe List do
  it { should have_and_belong_to_many :items }
  it { should validate_uniqueness_of(:name) }
end
