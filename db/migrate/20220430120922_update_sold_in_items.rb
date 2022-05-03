class UpdateSoldInItems < ActiveRecord::Migration[7.0]
  def change
    change_column :items, :sold, :boolean, default: false
  end
end
