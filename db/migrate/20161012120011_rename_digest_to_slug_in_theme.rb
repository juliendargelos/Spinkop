class RenameDigestToSlugInTheme < ActiveRecord::Migration
  def change
    rename_column :themes, :digest, :slug
  end
end
