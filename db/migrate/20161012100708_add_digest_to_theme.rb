class AddDigestToTheme < ActiveRecord::Migration
  def change
    add_column :themes, :digest, :string
  end
end
