namespace :slide do
  desc 'Init default slide for main page'
  task init: :environment do
    [
      'https://pbs.twimg.com/media/EtBXojgVgAEpZA1.jpg',
      'https://fortismp.com/wp-content/uploads/2015/08/Entrust_products.png',
      'https://direct-axis.net/wp-content/uploads/2020/01/TTG-Medical-Imaging-Capabilities-Brochure-2.jpg',
      'https://bestlifeonline.com/wp-content/uploads/sites/3/2021/05/medicine-storage-freezer.jpg',
      'https://www.cekindo.vn/wp-content/uploads/2019/04/medical-device-registration-vietnam.jpg'
    ].each_with_index do |url, index|
      puts 'Downloading image ...'
      slide = Slide.create(description_vi: "VI: Slide ##{index+1}", description_en: "EN: Slide ##{index+1}")
      slide.image.attach(
        io: URI.parse(url).open,
        filename: "slide##{index+1}"
      )
    end
  end
end
