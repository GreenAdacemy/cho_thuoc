# == Schema Information
#
# Table name: manufacturers
#
#  id         :bigint           not null, primary key
#  alias      :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Manufacturer < ApplicationRecord
  has_many :products
end
