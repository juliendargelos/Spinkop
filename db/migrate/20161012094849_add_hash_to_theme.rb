class AddHashToTheme < ActiveRecord::Migration
  def change
    add_column :themes, :hash, :string
  end
end
