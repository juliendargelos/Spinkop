class AddHashToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :hash, :string
  end
end
