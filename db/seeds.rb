# This file seeds initial data for development and test environments.
# It should be idempotent (safe to run multiple times).

puts "Seeding database..."

# ---- Admin user ----
if Rails.env.development?
  AdminUser.find_or_create_by!(email: 'admin@example.com') do |admin|
    admin.password = 'password'
    admin.password_confirmation = 'password'
  end
  puts "Admin user ensured (email: admin@example.com / password: password)"
end

# ---- Items ----
require "open-uri"

Item.destroy_all
puts "Old items cleared."

items = [
  {
    title: "Vintage Levi’s Denim Jacket",
    brand: "Levi’s",
    color: "Blue",
    size: "M",
    description: "Classic 80s denim jacket with worn-in look.",
    category: "Jackets",
    collection: "Fall 2025",
    status: "for_sale",
    price_cents: 8500,
    header_url: "https://picsum.photos/600/600?random=1",
    photo_urls: [
      "https://picsum.photos/600/600?random=2",
      "https://picsum.photos/600/600?random=3"
    ]
  },
  {
    title: "Silk Floral Dress",
    brand: "Dior",
    color: "Red",
    size: "S",
    description: "Elegant vintage silk dress with floral pattern.",
    category: "Dresses",
    collection: "Spring 2025",
    status: "sold",
    price_cents: 12000,
    header_url: "https://picsum.photos/600/600?random=4",
    photo_urls: [
      "https://picsum.photos/600/600?random=5",
      "https://picsum.photos/600/600?random=6"
    ]
  }
]

items.each do |attrs|
  item = Item.create!(
    title: attrs[:title],
    brand: attrs[:brand],
    color: attrs[:color],
    size: attrs[:size],
    description: attrs[:description],
    category: attrs[:category],
    collection: attrs[:collection],
    status: attrs[:status],
    price_cents: attrs[:price_cents]
  )

  # Attach header photo
  file = URI.open(attrs[:header_url])
  item.header_photo.attach(io: file, filename: "#{item.title.parameterize}-header.jpg", content_type: "image/jpg")

  # Attach extra photos
  attrs[:photo_urls].each_with_index do |url, i|
    file = URI.open(url)
    item.photos.attach(io: file, filename: "#{item.title.parameterize}-#{i + 1}.jpg", content_type: "image/jpg")
  end
end

puts "Seed complete: #{Item.count} items created."
