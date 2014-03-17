class CreateSnmps < ActiveRecord::Migration
  def change
    create_table :snmps do |t|

      t.timestamps
    end
  end
end
