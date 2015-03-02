class AddDropboxSessionToAdmin < ActiveRecord::Migration
  def change
    add_column :admins, :dropbox_session, :string
  end
end
