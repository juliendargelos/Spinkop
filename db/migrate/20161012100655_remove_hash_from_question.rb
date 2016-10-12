class RemoveHashFromQuestion < ActiveRecord::Migration
  def change
    remove_column :questions, :hash, :string
  end
end
