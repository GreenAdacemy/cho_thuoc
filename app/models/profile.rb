# == Schema Information
#
# Table name: profiles
#
#  id         :bigint           not null, primary key
#  address    :string
#  dob        :date
#  email      :string
#  first_name :string
#  last_name  :string
#  phone      :string
#  sex        :integer          default("unknown")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :avatar
  enum sex: [:unknown, :male, :female]
  store :address, accessors: [ :street , :city , :district, :ward, :ref, :zipcode ]

  attr_reader :full_address

  def full_name
    "#{self.first_name} #{self.last_name}" 
  end

  def thumbnail
    if self.avatar.attached?
      return url_for(self.avatar)
    end
  end

  def full_address
    address_str = ''
    address_str << self.address[:city] << ', ' if self.address[:city]
    address_str << self.address[:ref].to_s << ', ' if self.address[:ref]
    address_str << self.address[:street] if self.address[:street]
    address_str
  end
end
