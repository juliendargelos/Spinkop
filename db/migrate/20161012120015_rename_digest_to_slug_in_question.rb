class RenameDigestToSlugInQuestion < ActiveRecord::Migration
  def change
    rename_column :questions, :digest, :slug
  end
end
