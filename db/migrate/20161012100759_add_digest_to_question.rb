class AddDigestToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :digest, :string
  end
end
