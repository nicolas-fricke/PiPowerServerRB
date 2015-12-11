require 'rails_helper'

RSpec.describe CONFIG do
  subject { CONFIG }
  it { should be_a Hash }
  it { should have_key :commands }
  its([:commands]) { should have_key :switch }
end
