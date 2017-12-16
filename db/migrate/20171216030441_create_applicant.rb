class CreateApplicant < ActiveRecord::Migration[5.1]
  def change
    create_table :applicants do |t|
      t.string :name, default: ''
      t.string :email, default: ''
      t.string :phone, default: ''
      t.string :interview_status, default: 'pending'
      t.datetime :interview_date
      t.string :interview_result, default: ''
      t.string :invitation_status, default: 'pending'

      t.timestamps
    end
  end
end
