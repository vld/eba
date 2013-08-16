class AddDeltaToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :delta, :boolean, :default => true, :null => false
  end
end
