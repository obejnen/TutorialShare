class Admin::CommentsController < Admin::AdminController
    def index
        @search = Comment.ransack(params[:q])
        @comments = @search.result
    end

end