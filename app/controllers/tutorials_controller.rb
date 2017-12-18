class TutorialsController < ApplicationController
    def new
      @tutor = Tutorial.new
    end
  
    def create
      @tutorial = Tutorial.new(title: params[:title], body: params[:body])
      @tags = Tag.new(content: params[:tags])
      @tutorial.tags << @tags
      current_user.tutorials << @tutorial
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