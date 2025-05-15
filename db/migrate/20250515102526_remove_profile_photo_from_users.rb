class RemoveProfilePhotoFromUsers < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :profile_photo, :text
  end
end
