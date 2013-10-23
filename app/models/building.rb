class Building < ActiveRecord::Base
  validates :address,  presence: true
  validates :zip_code, presence: true, length: { maximum: 5, minimum: 5 }
end
