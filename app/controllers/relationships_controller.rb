class RelationshipsController < ApplicationController
  def create
    follower = current_user.follow(params[:id])
    if follower.save
      flash[:success] = 'ユーザーをフォローしました'
      redirect_to root_path
    else
      flash.now[:alert] = 'ユーザーのフォローに失敗しました'
      redirect_to root_path
    end
  end
  
  def destroy
    follower = current_user.unfollow(params[:id])
    if follower.destroy
      flash[:success] = 'ユーザーのフォローを解除しました'
      redirect_to root_path
    else
      flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
      redirect_to root_path
    end
  end
end
