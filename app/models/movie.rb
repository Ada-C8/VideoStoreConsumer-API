class Movie < ApplicationRecord
  attr_accessor :external_id

  has_many :rentals
  has_many :customers, through: :rentals

  def available_inventory
    self.inventory - Rental.where(movie: self, returned: false).length
  end

  # def self.construct_movie(api_result)
  #   Movie.new(
  #     title: api_result["title"],
  #     overview: api_result["overview"],
  #     release_date: api_result["release_date"],
  #     image_url: (api_result["poster_path"] ? self.construct_image_url(api_result["poster_path"]) : ''),
  #     external_id: api_result["id"])
  #   end
  #
  #   def self.construct_image_url(img_name)
  #     # return img_name
  #     return BASE_IMG_URL + DEFAULT_IMG_SIZE + img_name
  #   end
  #
  # end


  # def image_url
  #   orig_value = read_attribute :image_url
  #   if !orig_value
  #     MovieWrapper::DEFAULT_IMG_URL
  #   elsif external_id
  #     MovieWrapper.construct_image_url(orig_value)
  #   else
  #     orig_value
  #   end
  # end
end
