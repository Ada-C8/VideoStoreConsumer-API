class Movie < ApplicationRecord
  attr_accessor :external_id

  has_many :rentals
  has_many :customers, through: :rentals

  def available_inventory
    if self.inventory
      self.inventory - Rental.where(movie: self, returned: false).length
    end
  end

  def image_url
    puts "INSIDE image_url in movie.rb"
    orig_value = read_attribute :image_url
    puts "orig_value: #{orig_value}"
    if !orig_value
      MovieWrapper::DEFAULT_IMG_URL
    elsif external_id
      puts "inside elsif external_id"
      puts "external_id: #{external_id}"
      MovieWrapper.construct_image_url(orig_value)
    else
      orig_value
    end
  end
end
