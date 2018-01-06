class Admin::TutorialsController < Admin::AdminController
    def index
        @search = Tutorial.search(params[:q])
        @tutorials = @search.result
    end
end