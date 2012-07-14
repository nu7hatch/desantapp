class CreateSignups < ActiveRecord::Migration
  def change
    create_table :signups do |t|
      t.string :email,      :null => false
      t.string :ip_address, :null => false
      t.string :referrer

      t.timestamps
    end
  end
end
