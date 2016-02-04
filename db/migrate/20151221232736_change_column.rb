class ChangeColumn < ActiveRecord::Migration
  def change
  	remove_column :users,:nivel_permiso, :string
  	add_column :users,:permission_level, :integer,default: 1
  end
end
