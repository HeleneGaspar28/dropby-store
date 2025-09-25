class Item < ApplicationRecord
  has_many :order_items
  has_many :orders, through: :order_items

  has_one_attached :header_photo   # main image
  has_many_attached :photos

  STATUSES = %w[for_sale sold].freeze

  validates :status, inclusion: { in: STATUSES }
end
