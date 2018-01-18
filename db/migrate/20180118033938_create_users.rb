class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.string :email
      t.integer	:role
      t.integer	:group_size

      t.timestamps
    end
  end
end
