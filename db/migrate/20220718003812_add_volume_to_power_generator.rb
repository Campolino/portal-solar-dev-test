class AddVolumeToPowerGenerator < ActiveRecord::Migration[5.2]
  def change
    add_column :power_generators, :volume, :float
  end
end
