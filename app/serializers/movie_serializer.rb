class MovieSerializer < ActiveModel::Serializer
  attribute :id, if: -> { object.id != nil }

  attributes :title, :overview, :release_date, :average_rating, :image_url, :external_id
end
