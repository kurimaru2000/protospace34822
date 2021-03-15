class PrototypesController < ApplicationController

  def index
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

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept).merge(user_id: current_user.id)
  end

end
