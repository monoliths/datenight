class Place < ApplicationRecord
	# Validations
	validates_presence_of :name
	validates_presence_of :phone
	validates_presence_of :address
	validates_presence_of :user_id

	# Associations
	belongs_to :user
	has_many :reviews, dependent: :destroy

	# Normalizes the attribute itself before validation
  phony_normalize :phone, default_country_code: 'US'
	validates :phone, phony_plausible: true

	# Generating Coords
	geocoded_by :address
	after_validation :geocode

	# method an instance can call to find the average rating
	def average_rating
		self.reviews.sum(:score) / reviews.size
	rescue ZeroDivisionError
		0
	end

	# method for making a text search for places
	def self.search(term)
		if term
			where( [ 'name LIKE ? OR address LIKE ?', "%#{term}%", "#{term}%" ] )
		else
		  all
		end
	end
end
