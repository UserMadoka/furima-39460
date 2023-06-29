FactoryBot.define do
  factory :order_shipping do
    price         { 1000 }
    token         { 'tok_abcdefghijk00000000000000000' }
    postal_code   { '123-4567' }
    city          { 'Tokyo' }
    addresses     { '123 Main Street' }
    building      { 'Apt 4B' }
    phone_number  { '1234567890' }
    prefecture_id { 1 }
  end
end
