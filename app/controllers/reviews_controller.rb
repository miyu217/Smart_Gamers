class ReviewsController < ApplicationController
  before_action :set_game
  before_action :set_review, only: [:show, :edit, :update, :destroy, :toggle_good]

  def create
    @review = @game.reviews.build(review_params)
    @review.user = current_user
    if @review.save
      redirect_to game_review_path(@game, @review), notice: "レビューが投稿されました。"
    else
      @game = Game.find(params[:game_id])
      @reviews = @game.reviews
      review = @game.reviews.find_by(id: params[:id])
      render "games/show"
    end
  end

  def show
    @user = User.find(current_user.id)
    @good_count = @review.helpful_count
  end

  def toggle_good
    existing_vote = @review.voted_for?(current_user)

    if existing_vote
      flash[:notice] = 'You have already voted for this review.'
    else
      ReviewVote.create(user: current_user, review: @review)
      @review.increment!(:helpful_count)
    end
    redirect_to game_review_path(@game, @review)
  end

  def edit
    if @review.user == current_user
      render "edit"
    else
      redirect_to game_path(@game)
    end
  end

  def update
    if @review.update(review_params)
      redirect_to game_review_path(@game, @review), notice: "レビューが更新されました。"
    else
      render :edit
    end
  end

  def destroy
    @review.destroy
    redirect_to game_path(@game), alert: "レビューが削除されました。"
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end

  def set_review
    @review = @game.reviews.find_by(id: params[:id])
    unless @review
      flash[:alert] = "レビューが見つかりませんでした。"
      redirect_to game_path(@game)
    end
  end

  def review_params
    params.require(:review).permit(:seriousness_rating, :package_name, :spent_amount, :rating, :comment)
  end
end
