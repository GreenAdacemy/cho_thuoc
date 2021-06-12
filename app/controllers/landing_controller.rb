class LandingController < ApplicationController
    layout 'landing'
    before_action :fetch_product, :fetch_slide
    def index
  
    end


    private
    def fetch_slide
        @slides = Slide.all
    end

    def fetch_product
        @product = Product.all
    end


end
