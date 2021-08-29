# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  owner                  :integer          default("customer")
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :orders, dependent: :destroy
  has_many :shipping_infos, dependent: :destroy
  has_one :profile, dependent: :destroy
  enum owner: [:customer, :shop]
  after_commit :create_default_profile, on: :create 

  accepts_nested_attributes_for :profile, allow_destroy: true

  def update_profile(params)
    params[:sex]=params[:sex].to_sym
    self.profile.update(params)
  end

  AVATAR = Mime::LOOKUP.keys.keep_if{ |v| v =~ /image/ }
  
  def cart
    self.orders.in_cart.first
  end
  
  private
    def create_default_profile
      self.create_profile unless self.profile
    end
end
