class RostersController < ApplicationController
  def index
    if current_user.class == Professor
      @rosters = current_user.rosters
      render :index_professor
    elsif current_user.student?
      @rosters = current_user.rosters
      render :index_student
    end
  end
  
  def show
    @roster = Roster.find(params[:id])
    if current_user.class == Professor
      @students = @roster.users
      render :show_professor
    elsif current_user.student?
      @lessons = @roster.lessons
      render :show_student
    end
  end
  
  def new
    if current_user.class == Professor
      @roster = Roster.new
    end
  end
  
  def create
    if current_user.class == Professor
      @roster = Roster.new(roster_params)
      @roster.professor = current_user
      if @roster.save
        redirect_to roster_path(@roster)
      else
        render text: 'ERROR'
      end
    end
  end
  
  def update
    if current_user.class == Professor
      @roster = Roster.find(params[:id])
      if @roster.update_attributes!(update_roster_params)
        respond_to do |format|
          format.json {render :json => @roster}
        end
      else
        format.json { render :nothing =>  true }
      end
    end
  end
  
  private
  
  def roster_params
    params.require(:roster).permit(:title,user_ids: [])
  end
  
  def update_roster_params
    params.require(:roster).permit(:title,user_ids: [],lesson_ids: [])
  end
  
end