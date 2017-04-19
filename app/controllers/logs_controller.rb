class LogsController < ApplicationController
  before_action :authorize_user, only: [:destroy, :edit, :update]
  impressionist actions: [:show]

  def index
    @logs = Log.all
    if params[:search]
      @logs = Log.search(params[:search]).order("created_at DESC")
    else
      @logs = Log.all.order("created_at DESC")
    end
  end

  def all_logs
    @logs = Log.all
  end

  def show
    @log = Log.find(params[:id])
    unless @log.public || current_user
      flash[:alert] = "You must be signed in to view private logs."
      redirect_to root_path
    end
  end

  def new
    @log = Log.new
    @categories = Category.all.map{|c| [c.name, c.id] }
  end

  def create
    @log = Log.new(log_params)
    @log.category_id = params[:category_id]
    @log.user = current_user
    @categories = Category.all.map{|c| [c.name, c.id] }

    if current_user.logs.today.count <= 2 || current_user.premium?
      @log.save
      flash[:notice] = "Log was saved successfully."
      redirect_to @log
    elsif current_user.logs.today.count > 2
      flash.now[:alert] = "Exceeded post limit for today. Upgrade to premium for unlimited sharing"
      render :new
    end
  end

  def edit
    @log = Log.find(params[:id])
    @categories = Category.all.map{|c| [c.name, c.id ] }

    respond_to do |format|
     format.html
     format.js
   end
  end

  def update
   @log = Log.find(params[:id])
   @log.category_id = params[:category_id]

   if @log.update_attributes(log_params)
     flash[:notice] = "log was updated successfully."
     redirect_to @log
   else
     flash.now[:alert] = "There was an error saving the log. Please try again."
     render :edit
   end
 end

 def destroy
   @log = Log.find(params[:id])

   if @log.destroy
     flash[:notice] = "\"#{@log.title}\" was deleted successfully."
     redirect_to logs_path
   else
     flash.now[:alert] = "There was an error deleting the log."
     render :show
   end
 end

  private

  def log_params
    params.require(:log).permit(:title, :body, :description, :image, :category_id, :public)
  end

  def authorize_user
    log = Log.find(params[:id])
    unless current_user == log.user || current_user.admin?
      flash[:alert] = "You do not have acesss to do that"
      redirect_to root_path
    end
  end
end
