class BucketlistsController < ApplicationController
  def new

  end

  def create
    @bucketlist = Bucketlist.new(bucketlist_params)
    @bucketlist.user_id = params[:user_id]
    if @bucketlist.save
      redirect_to "/users/#{@bucketlist.user_id}"
    else
      redirect_to "/users/#{@bucketlist.user_id}" #add error message and render the show page
    end
  end

  def delete
   @bucketlist = Bucketlist.find_by(id: params[:bucketlist_id])
   @user = @bucketlist.user
   @bucketlist.destroy
   redirect_to user_path(@user)
 end

  private
  def bucketlist_params
    params.require(:bucketlist).permit(:name, :description)
  end
end
