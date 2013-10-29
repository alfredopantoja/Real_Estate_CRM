class Building < ActiveRecord::Base
  belongs_to :landlord
  has_many :tenants
  validates :address,  presence: true
  validates :zip_code, presence: true, length: { maximum: 5, minimum: 5 }
end
