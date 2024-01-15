class AdminsController < ApplicationController
  before_action :authenticate_admin
  before_action :set_request, only: [:show, :approve, :reject, :edit, :update]

  def index
    @requests = Request.all
    @pending_approval_requests = Request.pending_approval
    @approved_requests = Request.approved
    @rejected_requests = Request.rejected
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      flash[:notice]="ゲームが追加されました！"
      redirect_to game_path(@game)
    else
      @requests = Request.all
      render "index"
    end
  end

  def show
    @user = @request.user
  end

  def approve
    if @request.approve!
      redirect_to admin_requests_path, notice: 'リクエストが承認されました。'
    else
      redirect_to admin_requests_path, alert: 'リクエストの承認に失敗しました。'
    end
  end

  def reject
    if @request.reject!
      redirect_to admin_requests_path, notice: 'リクエストが拒否されました。'
    else
      redirect_to admin_requests_path, alert: 'リクエストの拒否に失敗しました。'
    end
  end

  private

  def game_params
    params.require(:game).permit(:title, :status, :genre, :release_date, :developer, :price, :payment_details)
  end

  def set_request
    @request = Request.find(params[:id])
  end

  def authenticate_admin
    redirect_to root_path, alert: "アクセス権限がありません。" unless current_user&.admin?
  end
end
