class CreateRealPatents < ActiveRecord::Migration
  def self.up
    create_table :real_patents do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :real_patents
  end
end
