class RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_request, only: [:show, :edit, :update, :destroy]

  def index
    @requests = @user.requests
  end

  def show
    @request = Request.find(params[:id])
  end

  def new
    @request = Request.new
  end

  def create
    @request = @user.requests.build(request_params)

    if @request.save
      flash[:notice]="リクエストが送信されました。"
      redirect_to user_path(@user)
    else
      flash[:alert] = "リクエストの送信に失敗しました。"
      render "new"
    end
  end

  def edit
    @request = Request.find(params[:id])
  end

  def update
    @request = Request.find(params[:id])
    if @request.update(request_params)
      flash[:notice] = 'リクエストが更新されました。'
      redirect_to user_request_path(@request)
    else
      render 'edit'
    end
  end

  def destroy
    @request = Request.find(params[:id])
    if @request.destroy
      flash[:notice] = 'リクエストが削除されました。'
    else
      flash[:notice] = 'リクエストの削除に失敗しました。'
    end
    redirect_to user_requests_path
  end


  private

  def set_user
    @user = User.find(current_user.id)
  end

  def set_request
    @request = Request.find(params[:id])
  end

  def request_params
    params.require(:request).permit(:title, :description)
  end
end
