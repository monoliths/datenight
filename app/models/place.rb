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
end
