class CreateFakePatents < ActiveRecord::Migration
  def self.up
    create_table :fake_patents do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :fake_patents
  end
end
