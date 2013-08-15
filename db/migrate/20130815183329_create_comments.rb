class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.references :manager
      t.references :issue

      t.timestamps
    end
    add_index :comments, :manager_id
    add_index :comments, :issue_id
  end
end
