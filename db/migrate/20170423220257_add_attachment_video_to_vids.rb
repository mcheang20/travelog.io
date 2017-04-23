class AddAttachmentVideoToVids < ActiveRecord::Migration[5.0]
  def up
    add_attachment :vids, :video
  end

  def down
    remove_attachment :vids, :video
  end
end
