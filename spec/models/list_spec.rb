require 'spec_helper'

describe List do
  it { should have_and_belong_to_many :items }
end
