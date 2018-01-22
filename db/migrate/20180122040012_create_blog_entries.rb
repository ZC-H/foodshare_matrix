class CreateBlogEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :blog_entries do |t|
    	t.string :title
    	t.string :description
    	t.belongs_to	:user

      t.timestamps
    end
  end
end

