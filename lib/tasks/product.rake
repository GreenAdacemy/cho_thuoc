namespace :product do
  desc 'Init default product for project'
  task init: :environment do
    puts 'Fetching data'
    fetch_data.each_with_index do |item, index|
      manufacturer = Manufacturer.find_or_create_by(
        name: item['manufacturer'],
        alias: item['manufacturer'][0..5]
      )
      product = Product.create(
        description_vi: "VI: #{item['description']}",
        description_en: "EN: #{item['description']}",
        hot: item['hot'],
        name: item['name'],
        pakage: item['pakage'],
        price: item['price'],
        sku: item['sku'],
        unit: item['unit'],
        manufacturer_id: manufacturer.id
      )
      puts 'generate photo'
      product.image.attach(
        io: URI.parse("https://loremflickr.com/720/576?lock=#{index}").open,
        filename: "product##{index+1}"
      )
    end
  end

  private
  def fetch_data
    JSON.parse(File.read(json_file))
  end

  def json_file
    Rails.root.join('db/products.json')
  end
end
