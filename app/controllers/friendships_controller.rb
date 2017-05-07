class FriendshipsController < ApplicationController

  def destroy
    @friendship = current_user.friendships.where(friend_id: params[:id]).first
    @friendship.destroy
    flash[:notice] = "Friend was succesfully removed"
    respond_to do |format|
      format.html { redirect_to my_friends_path }
    end
  end

end