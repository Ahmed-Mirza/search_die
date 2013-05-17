class CreateSearchContents < ActiveRecord::Migration
  def change
    create_table :search_contents do |t|
      t.string :content

      t.timestamps
    end
  end
end
