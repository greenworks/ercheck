class CreateRehireFlags < ActiveRecord::Migration
  def change
    create_table :rehire_flags do |t|
      t.string :value

      t.timestamps
    end
  end
end
