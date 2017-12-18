class TutorialsController < ApplicationController
    def new
      @tutor = Tutorial.new
    end
  
    def create
      @tutorial = Tutorial.new(params.require(:tutorial).permit(:title, :body))
      @tags = Tag.new(params.require(:tag).permit(:content))
      current_user.tutorials << Tutorial.new(params.require(:tutorial).permit(:title, :body))
      redirect_to current_user.tutorials.last
    end
  
    # def create
    #   @user = current_user
    #   @tutor = @user.tutorials.build()
    #   redirect_to tutorial_path(current_user)
    # end
  
    def show
      @tutor = Tutorial.find(params[:id])
    end
  
    def index
      @tutorials = Tutorial.all.sort_by{|m| m.created_at}.reverse
    end
  end