module ApplicationHelper
  def preload_image
    asset_pack_path 'media/images/loading.gif'
  end
  
  def load_image (obj)
    return obj if obj.image.is_a?(String)
    return default_image unless obj.image.attached?
    if ActiveStorage::Blob.service.class.name.include?('Disk')
      url_for(obj.image)
    end
  end

  def default_image
    asset_pack_path 'media/images/No_img.jpg'
  end
  
  def fecth_product
    @products=Product.all
  end
  
  def sexes
    Profile::sexes.map {|v,k| [k, v]}
  end

  def fetch_data(json_file = nil)
    File.exists?(json_file) ? JSON.parse(File.read(json_file)) : []
  end

  def check_current_lang(lang)
    I18n.locale.to_sym == lang.to_sym
  end

  def accept_only_excel
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel'
  end

  def accept_only_csv
    '.csv'
  end

  def accept_only_office
    accept_only_excel << ',' << accept_only_csv    
  end
end
