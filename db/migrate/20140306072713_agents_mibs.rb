class AgentsMibs < ActiveRecord::Migration
  def self.up
    create_table :agents_mibs, :id => false do |t|
      t.integer "agent_id"
      t.integer "mib_id"
      t.integer "mib_objects"
      t.integer "mib_id"
    end
  end

  def self.down
    drop_table :agents_mibs
  end
end
