class RemoveHashFromTheme < ActiveRecord::Migration
  def change
    remove_column :themes, :hash, :string
  end
end
