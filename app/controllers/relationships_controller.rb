class RelationshipsController < ApplicationController
  before_action :signed_in_user

  def create
    puts "=================="
    puts current_user.id
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    #puts current_user.follow!(@user)
    #respond_to do |format|
    #  format.html { redirect_to @user }
    #  format.js
    #end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
