class AddLatAndLonToSignups < ActiveRecord::Migration
  def up
    change_table :signups do |t|
      t.float :lat
      t.float :lon
    end
  end

  def down
    remove_column :signups, :lat
    remove_column :signups, :lon
  end
end
