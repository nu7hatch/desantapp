class AddCachedLocationToSignups < ActiveRecord::Migration
  def up
    change_table :signups do |t|
      t.string :city
      t.string :country
    end
  end

  def down
    remove_column :signups, :city
    remove_column :signups, :country
  end
end
