class RenameVotesVotableIdColumn < ActiveRecord::Migration
  def change
    rename_column :votes, :votable_id, :voteable_id
    rename_column :votes, :votable_type, :voteable_type
  end
end
