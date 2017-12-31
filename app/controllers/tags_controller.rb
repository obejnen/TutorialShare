class TagsController < ApplicationController
    def show
        @tag = Tag.find_by(name: params[:id])
        @tutorials = @tag.tutorials
    end
end