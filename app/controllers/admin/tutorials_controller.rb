class Admin::TutorialsController < ApplicationController
    layout "admin_layout"

    def index
        @tutorial = Tutorial.all
    end
end