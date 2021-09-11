Trestle.resource(:products) do
  menu do
    item :products, icon: "fa fa-star"
  end

  active_storage_fields do
    [:image]
  end

  # Customize the table columns shown on the index view.

  table do
    column :id
    column :name 
    column :image ,header: false do |slide|
      content_tag :div, class: 'admin-image' do
        content_tag(:div, nil, class: 'thumbnail lozad', 'data-background-image': slide.thumbnail, src: preload_image)
      end.html_safe
    end
    column :hot
    column :price
    column :description
    column :created_at, align: :center
    column :updated_at
    actions
  end

  # Customize the form fields shown on the new/edit views.
  #
  form dialog:true do |slide|
    text_field :name
    number_field :price
    check_box    :hot
    active_storage_field :image 
    I18n.available_locales.each do |locale|
      tab t("admin.#{locale}") do
        text_area "description_#{locale}".to_sym, label: 'Descriptions', placeholder: 'Input your description here', class: "admin-slide-description"

      end
    end
    select :manufacturer_id, Manufacturer.all.map{|obj| [obj.name, obj.id ] }
  end

  controller do
    def import
      @import = ImportManagement.new()
    end

    def import_file
      if params[:import_management]
        import_params = params.require(:import_management).permit(:file)
        ImportManagement.create(
          import_params.merge({from: 'admin:products', to: Product.table_name})
        )
      end
      redirect_to products_admin_index_path
    end
  end

  routes do
    get :import, on: :collection
    post :import_file, on: :collection
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:product).permit(:name, ...)
  # end
end
