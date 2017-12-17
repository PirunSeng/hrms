RSpec.describe Department, 'associations' do
  it { is_expected.to have_many(:users).dependent(:restrict_with_error) }
end

RSpec.describe Department, 'validation' do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
end
