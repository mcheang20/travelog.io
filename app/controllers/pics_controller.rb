class PicsController < ApplicationController
  before_action :require_sign_in, except: [:index, :show]
  before_action :authorize_user, only: [:destroy]

  def show
    @log = Log.find(params[:id])
    @pic = @log.pics.all
  end

  def create
   @log = Log.find(params[:log_id])
   @pic = @log.pics.new(pic_params)

   if @pic.save
     flash[:notice] = "Image saved successfully."
     redirect_to [@log]
   else
     flash[:alert] = "Image failed to save."
     redirect_to [@log]
   end
  end

  def destroy
  @log = Log.find(params[:log_id])
  @pic = @log.pics.find(params[:id])

  if @pic.destroy
    flash[:notice] = "Image was deleted successfully."
    redirect_to log_pic_path(@log.pics, @log)
  else
    flash[:alert] = "Image couldn't be deleted. Try again."
    redirect_to log_pic_path(@log.pics, @log)
  end
  end

  private

  def pic_params
    params.require(:pic).permit(:caption, :image)
  end

  def authorize_user
    pic = Pic.find(params[:id])
    unless current_user == pic.log.user || current_user.admin?
      flash[:alert] = "You do not have permission to delete this image"
      redirect_to [pic.log]
    end
  end
end
