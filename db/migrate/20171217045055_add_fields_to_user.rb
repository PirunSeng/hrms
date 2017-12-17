class AddFieldsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string, default: ''
    add_column :users, :phone, :string, default: ''
    add_column :users, :address, :string, default: ''
    add_column :users, :salary, :integer, default: 0
    add_column :users, :start_date, :date
    add_column :users, :performance, :string, default: ''

    add_reference :users, :position, index: true, foreign_key: true
    add_reference :users, :department, index: true, foreign_key: true
  end
end
