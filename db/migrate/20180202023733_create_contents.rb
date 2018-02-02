class CreateContents < ActiveRecord::Migration[5.2]
  def change
    create_table :contents do |t|
      t.string :title
      t.string :author
      t.string :summary
      t.text :content
      t.boolean :state
      t.datetime :published_date
    end
  end
end
