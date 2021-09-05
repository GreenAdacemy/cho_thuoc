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
  enum status: [:waiting, :preparing, :prepared, :started, :wip, :doned, :error, :pending, :stoped]

  after_commit :add_job, on: [:create]

  private
  def add_job
    ImportFileJob.perform_later self.id
  end
end
