class AddCounterToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :post_count, :integer
    add_index :topics, :post_count
  end
end
