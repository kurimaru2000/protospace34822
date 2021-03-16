class PrototypesController < ApplicationController

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
  end

  def edit
    @prototype = Prototype.find(params[:id])
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
    # 削除したい特定のidを持つツイートを１つ探してくる
    prototype.destroy
    # 上で選択したレコードをアクティブレコードメソッドのデストロイで削除している
    # 今回のデストロイアクションはビューに情報を受け渡さないのでtweetはインスタンス変数ではなくただの変数として置いている
    if prototype.destroy
      redirect_to root_path      
    end
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
    # binding.pry
  end

end
