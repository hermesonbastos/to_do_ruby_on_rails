class AddGoogleTokensToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :token, :string
    add_column :users, :refresh_token, :string
    add_column :users, :token_expires_at, :datetime
  end
end
