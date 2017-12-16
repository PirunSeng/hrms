class Applicant < ApplicationRecord
  INTERVIEW_RESULTS = ['passed', 'failed'].freeze
  INTERVIEW_STATUSES = ['pending', 'shortlist', 'done'].freeze
  INVITATION_STATUSES = ['pending', 'invited'].freeze

  validates :name, :interview_date, :phone, presence: true
  validates :phone, :email, presence: true, uniqueness: { case_sensitive: false }
  validates :interview_result, presence: true, if: :done_interviewing?

  private

  def done_interviewing?
    interview_status == 'done'
  end
end
