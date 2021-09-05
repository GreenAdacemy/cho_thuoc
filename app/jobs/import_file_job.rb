class ImportFileJob < ApplicationJob
  queue_as :import

  def perform(*args)
    im = ImportManagement.find_by(id:args.first)
    im.started!
    im.file.open do |file|
      @office = Office.new({file: file})
    end
    im.wip!
    select_action im
  end
  
  private
  def select_action(im)
    case im.to
    when 'products'
      import_product(im)
    when 'user'      
    else
      
    end
  end

  def import_product(im)
    @office.each_row('Models::Product.new') do |product|
      if product.manufacturer[:id].nil?
        data = product.fields(nested_attributes: true, for_create: true)
      else
        data = product.product.merge(
          {
            manufacturer_id: product.manufacturer[:id]
          }
        )
      end
      p data
      Product.create(data)
    end
    im.doned!
  end
end
