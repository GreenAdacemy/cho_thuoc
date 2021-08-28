# == Schema Information
#
# Table name: products
#
#  id              :bigint           not null, primary key
#  description     :text
#  description     :text
#  hot             :boolean
#  name            :string
#  pakage          :string
#  price           :integer          default(0)
#  sku             :string
#  unit            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  manufacturer_id :bigint           not null
#
# Indexes
#
#  index_products_on_manufacturer_id  (manufacturer_id)
#
# Foreign Keys
#
#  fk_rails_...  (manufacturer_id => manufacturers.id)
#
class Product < ApplicationRecord
    belongs_to :manufacturer, optional:true
    has_one_attached :image
    translates :description

    globalize_accessors :locales => I18n.available_locales, :attributes => [:description]

    def thumbnail
        if self.image.attached?
            return url_for(self.image)
        end
    end
end
