class ChangeStringToText < ActiveRecord::Migration
  def self.up
    change_column :fake_patents, :name, :text, :limit => nil
    change_column :real_patents, :name, :text, :limit => nil
  end

  def self.down
    change_column :fake_patents, :name, :string, :limit => nil
    change_column :real_patents, :name, :string, :limit => nil
  end
end
