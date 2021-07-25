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

  def full_name
    "#{self.first_name} #{self.last_name}" 
  end

end
