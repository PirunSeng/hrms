describe Position, 'associations' do
  it { is_expected.to have_many(:users).dependent(:restrict_with_error) }
end

describe Position, 'validation' do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_uniqueness_of(:title).case_insensitive }
end
