class CreateBusinessHours < ActiveRecord::Migration[7.0]
  def change
    create_table :business_hours do |t|

      t.string :opening_period
      t.timestamps
      t.belongs_to :shop, index: true
    end
  end
end
