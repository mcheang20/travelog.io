class VidsController < ApplicationController
  before_action :require_sign_in, except: [:show]

  before_action :authorize_user, only: [:destroy]

  def show
    @log = Log.find(params[:id])
    @vid = @log.vids.all
  end

 def create
   @log = Log.find(params[:log_id])
   @vid = @log.vids.new(vid_params)

   if @vid.save
     flash[:notice] = "Video uploaded successfully."
     redirect_to [@log]
   else
     flash[:alert] = "Video failed to save."
     redirect_to [@log]
   end
 end

 def destroy
  @log = Log.find(params[:log_id])
  @vid = @log.vids.find(params[:id])
  @vid.log = @log

    if @vid.destroy
      flash[:notice] = "Image was deleted successfully."
      redirect_to [@log]
    else
      flash[:alert] = "Image couldn't be deleted. Try again."
      redirect_to [@log]
    end
  end

private

 def vid_params
   params.require(:vid).permit(:caption, :video)
 end

   def authorize_user
     vid = vid.find(params[:id])
   unless current_user == vid.log.user || current_user.admin?
     flash[:alert] = "You do not have permission to delete this image"
     redirect_to [vid.log]
   end
  end
end
