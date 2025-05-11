class AddBannerToBoards < ActiveRecord::Migration[8.0]
  def change
    add_column :boards, :banner, :text
  end
end
