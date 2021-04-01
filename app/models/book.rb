require 'csv'

class Book < ApplicationRecord
  searchkick

  validates :title, presence: true
  validates :author, presence: true
  validates :publisher, presence: true
  validates :category, presence: true
  validates :published_on, presence: true

  composed_of :unit_cost,
              :class_name => 'Money',
              :mapping => [%w(unit_cost fractional), %w(currency currency_as_string)],
              :constructor => Proc.new { |unit_cost, currency| Money.new(unit_cost, currency || Money.default_currency) },
              :converter => Proc.new { |value| value.respond_to?(:to_money) ? (value.to_f.to_money rescue Money.empty) : Money.empty }

  CSV_FILE = File.join( Rails.root.to_s, 'db', "import", "books.csv")

  def price
    unit_cost.to_d * ( 1 + MARKUP[self.category] )
  end

  def display_price
    price.to_s
  end

  def self.import_csv(file)
    begin
      CSV.foreach(CSV_FILE, { headers: true, header_converters: :symbol }) do |row|
        book = Book.find_or_initialize_by(title: row[:title], author: row[:author], publisher: row[:publisher], category: row[:category], published_on: row[:published_on])
        book.attributes = row.to_hash.merge({:currency => "USD"})
        book.unit_cost = row[:unit_cost].to_f * 100.0
        book.save!
      end
    rescue Exception => e
      puts e.message
      puts "Book could not be created"
    end
  end

end
