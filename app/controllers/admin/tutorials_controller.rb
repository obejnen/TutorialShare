class Admin::TutorialsController < Admin::AdminController
    def index
        @tutorials = Tutorial.all
    end
end