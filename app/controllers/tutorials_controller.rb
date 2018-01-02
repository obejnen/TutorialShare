class TutorialsController < ApplicationController

    before_action :set_tutorial, only: [ :show, :edit, :destroy, :update ]
    before_action :authenticate_user!, except: [:show, :index]
    before_action :force_json, only: [:search]

    def index
        @tutorials = Tutorial.paginate(page: params[:page], per_page: 5)
    end

    def show
    end

    def new
        @tutorial = Tutorial.new
    end

    def create
        @tutorial = Tutorial.new(tutorial_params)
        if @tutorial.save
            redirect_to @tutorial, success: "Tutorial successfully created"
        else
            flash.now[:danger] = "Tutorial doesn't created"
            render :new
        end
    end

    def edit
    end

    def update
        if @tutorial.update_attributes(tutorial_params)
            flash.now[:success] = "Tutorial doesn't updated"            
            redirect_to @tutorial
        else
            flash.now[:danger] = "Tutorial doesn't updated"
            render :edit
        end
    end

    def destroy
        @tutorial.destroy
        redirect_to tutorials_path, success: "Tutorial success deleted"
    end

    def autocomplete
        @tutorials = Tutorial.ransack(title_cont: params[:q]).result(distinct: true).limit(5)
    end

    def search
        @tutorials = Tutorial.ransack(body_or_title_or_description_cont: params[:q]).result(distinct: true)
        @tutorials |= Comment.ransack(body_cont: params[:q]).result(distinct: true).map(&:tutorial)
        respond_to do |format|
            format.html {}
            format.json {
                @tutorials
            }
        end
        end

    private

    def tutorial_params
        params.require(:tutorial).permit(:title, :description, :body, :image, :all_tags, :category_id).merge(user_id: current_user.id)
    end

    def set_tutorial
        @tutorial = Tutorial.find(params[:id])
        @comments = @tutorial.comments
    end

    def force_json
        request.format = :json
    end
end