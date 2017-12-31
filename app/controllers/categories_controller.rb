class CategoriesController < ApplicationController
    before_action :set_category, only: [ :show ]
    def show
        @tutorials = Tutorial.where(category_id: @category.id).paginate(page: params[:page], per_page: 5)
    end

    private

    def set_category
        @category = Category.find(params[:id])
    end
end