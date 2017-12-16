describe Position, 'validation' do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_uniqueness_of(:title).case_insensitive }
end
