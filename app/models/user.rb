class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Validations
  validates_presence_of :name

  # Associations
  has_many :places, dependent: :destroy 
  has_many :reviews, dependent: :destroy
end
