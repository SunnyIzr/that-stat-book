class ChoicesController < ApplicationController
  def show
    @choice = Choice.find(params[:id])
    if current_user.admin?
      respond_to do |format|
        format.json {render :json => @choice}
      end
    end
  end
  
  def update
    @choice = Choice.find(params[:id])
    if @choice.update_attributes!(choice_params)
      respond_to do |format|
        format.json { render :json => @choice }
      end
    end
  end
  
  private
  def choice_params
    params.require(:choice).permit(:choice)
  end
  
end
