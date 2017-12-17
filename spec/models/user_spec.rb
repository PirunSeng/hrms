RSpec.describe User, 'associations' do
  it { is_expected.to belong_to(:department) }
  it { is_expected.to belong_to(:position) }
end

RSpec.describe User, 'validations' do
  it { is_expected.to validate_presence_of(:address) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:phone) }
  it { is_expected.to validate_presence_of(:salary) }
  it { is_expected.to validate_presence_of(:start_date) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to validate_uniqueness_of(:phone).case_insensitive }
end
