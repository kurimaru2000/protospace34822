class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :delete]
  before_action :move_to_index, only: [:edit]

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

  def move_to_index
    unless user_signed_in?
      # ログインしているかどうかを判定するメソッド
      redirect_to action: :index
      # 別の画面に変遷させる行
      # あんれすはいふと逆の動きでfailesを返した時に該当のアクションをする。
    end
  end

end
