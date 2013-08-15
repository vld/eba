class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :customer_name
      t.string :customer_email
      t.string :department
      t.string :subject
      t.text :body
      t.string :code
      t.string :state
      t.references :manager

      t.timestamps
    end
    add_index :issues, :manager_id
  end
end
