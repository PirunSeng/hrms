RSpec.describe Applicant do
  describe 'CONSTANTS' do
    context 'INTERVIEW_RESULTS' do
      it { expect(Applicant::INTERVIEW_RESULTS).to eq(['passed', 'failed']) }
    end

    context 'INTERVIEW_STATUSES' do
      it { expect(Applicant::INTERVIEW_STATUSES).to eq(['pending', 'shortlist', 'done']) }
    end

    context 'INVITATION_STATUSES' do
      it { expect(Applicant::INVITATION_STATUSES).to eq(['pending', 'invited']) }
    end
  end

  describe 'validations' do
    let!(:applicant) { create(:applicant) }

    it { is_ecpected.to validate_presence_of(:email) }
    it { is_ecpected.to validate_presence_of(:interview_date) }
    it { is_ecpected.to validate_presence_of(:name) }
    it { is_ecpected.to validate_presence_of(:phone) }
    it { is_ecpected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_ecpected.to validate_uniqueness_of(:phone).case_insensitive }
    context 'when done interviewing' do
      it 'should validate that :interview_result cannot be empty/falsy' do
        applicant.interview_status = 'done'
        expect(applicant.valid?).to be_falsey
        expect(applicant.errors.full_messages).to include(/Interview result can't be blank/)
      end
    end
  end
end
