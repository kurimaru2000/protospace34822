class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :destroy, :edit]
  

  def index
    @prototypes = Prototype.all
  end
  
  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new      
    end
  end

  def new
    @prototype = Prototype.new 
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
    unless @prototype.user_id == current_user.id
      redirect_to action: :index
    end
  end
  

  def update
    @prototype = Prototype.find(params[:id])
    @prototype.update(prototype_params)
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype.id), method: :get
    else
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    unless prototype.user_id == current_user.id
        redirect_to action: :index
    else
        prototype.destroy
        redirect_to action: :index
    end
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
    # binding.pry
  end
end
