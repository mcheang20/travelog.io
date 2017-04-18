class VotesController < ApplicationController
  before_action :require_sign_in

  def create
    @log = Log.find(params[:log_id])
    @vote = @log.votes.new(log: @log)
    @vote.user = current_user

    if @vote.save
      @vote.update_attribute(:value, 1)
    else

      @vote = current_user.votes.create(value: 1, log: @log)
    end
    redirect_to logs_path
  end

  def destroy
    @log = Log.find(params[:log_id])
    @vote = current_user.votes.find(params[:id])

    if @vote.destroy
      @vote.update_attribute(:value, -1) unless @vote.destroyed?
    else
      @vote = current_user.votes.create(value: -1, log: @log)
    end
    redirect_to logs_path
  end

  private

  def vote_params
    params.require(:vote).permit(:value)
  end
end
