module Models
  class Product
    attr_reader :product, :manufacturer
    def initialize(data = {})
      @data = data
      @product= self.generate_product
      @manufacturer = self.generate_manufacturer
    end

    def fields(options = {nested_attributes: false, for_create: false})
      options.merge!({for_create: true}) unless options.has_key?(:for_create)
      return self.nested_attributes(options[:for_create]) if options[:nested_attributes]
      @product
    end

    private
    def generate_product
      {
        name: @data[:name],
        price: @data[:price],
        pakage: @data[:pakage],
        sku: @data[:sku],
        hot: @data[:hot],
        unit: @data[:unit]
      }.merge(self.generate_description)
    end

    def generate_description
      I18n.available_locales.reduce({}){
        |h, locale| h.merge(
          Hash["description_#{locale}".to_sym, @data[:description]]
          )
      }
    end

    def generate_manufacturer
      self.manufacturer_for_create.merge(
        {
          id: Manufacturer.find_by(name: @data[:manufacturer])&.id
        }
      )
    end

    def manufacturer_for_create
      {
        name: @data[:manufacturer],
        alias: @data[:manufacturer],
      }
    end

    def nested_attributes(for_create)
      @product.merge(
        {
          manufacturer_attributes: for_create ? self.manufacturer_for_create : self.manufacturer
        }
      )
    end
  end
end