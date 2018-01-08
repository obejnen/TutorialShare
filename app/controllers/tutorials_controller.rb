class TutorialsController < ApplicationController

    before_action :set_tutorial, only: [ :show, :edit, :destroy, :update ]
    before_action :authenticate_user!, except: [:search, :show, :index, :recent]

    def index
        @tutorials = Tutorial.paginate(page: params[:page], per_page: 5).order(created_at: :desc)
    end

    def show
    end

    def new
        @tutorial = Tutorial.new
    end

    def recent
        @tutorials = Tutorial.paginate(page: params[:page], per_page: 5).order(updated_at: :desc)
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

    def search
        @tutorials = Tutorial.ransack(body_or_title_or_description_cont: params[:q]).result(distinct: true)
        @tutorials |= Comment.ransack(body_cont: params[:q]).result(distinct: true).map(&:tutorial)
        respond_to do |format|
            format.html { }
            format.json { @tutorials }
        end
    end

    private

    def tutorial_params
        # user = params.require(:tutorial).permit(:user) || current_user.id
        # puts user
        params.require(:tutorial).permit(:title, :description, :body, :image, :all_tags, :category_id, :user_id)
        # .merge(user_id: user)
    end

    def set_tutorial
        @tutorial = Tutorial.find(params[:id])
        @comments = @tutorial.comments
    end
end