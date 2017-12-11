describe Position, 'validation' do
  it { should validate_presence_of(:title) }
  it { should validate_uniqueness_of(:title).case_insensitive }
end
