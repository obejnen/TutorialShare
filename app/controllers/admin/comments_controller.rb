class Admin::CommentsController < ApplicationController
    layout "admin_layout"

    def index
        @comments = Comment.all
    end
end