class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.string :customer_name
      t.string :customer_email
      t.text :shipping_address
      t.string :shipping_postal_code
      t.string :shipping_city
      t.string :shipping_country
      t.string :status
      t.string :stripe_session_id

      t.timestamps
    end
  end
end
