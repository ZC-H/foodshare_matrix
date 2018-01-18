class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.name :string
      t.email :string
      t.role :integer
      t.group_size :integer

      t.timestamps
    end
  end
end
