# == Schema Information
#
# Table name: import_managements
#
#  id          :bigint           not null, primary key
#  description :string
#  from        :string
#  status      :integer          default(0)
#  to          :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class ImportManagement < ApplicationRecord
  has_one_attached :file
  enum status: [:waiting, :prepare, :started, :doned, :error, :pending, :stoped]
end
