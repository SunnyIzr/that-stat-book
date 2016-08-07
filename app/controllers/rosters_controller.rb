class RostersController < ApplicationController
  def index
    if current_user.class == Professor
      @rosters = current_user.rosters.sort!
      @roster_stats = @rosters.map{|roster| [roster,roster.stats] }
      render :index_professor
    elsif current_user.student?
      @class_request = ClassRequest.new
      @user = current_user
      @rosters = current_user.rosters
      @professors = Professor.all.select{ |prof| prof.school == @user.school }
      render :index_student
    elsif current_user.admin?
      @rosters = Roster.all.sort_by{ |roster| roster.professor.list_name }
      render :index_admin
    end
  end
  
  def show
    @roster = Roster.find(params[:id])
    if current_user.class == Professor
      @roster_stats = @roster.stats
      @new_student = User.new
      @all_lessons = Lesson.all.sort_by { |lesson| lesson.level }
      @students = @roster.users.sort_by {|student| student.last_name }
      @student_stats = @students.map{|student| [student,student.stats(@roster)]}
      @all_students = User.all.select{ |user| user.student? }.sort_by{ |student| student.last_name } - @students
      render :show_professor
    elsif current_user.student?
      @accessible_lessons = current_user.accessible_roster_lessons(@roster.id)
      @user = current_user
      @lessons = @roster.lessons.sort_by { |lesson| lesson.level }
      render :show_student
    elsif current_user.admin?
      @students = @roster.users.sort_by {|student| student.last_name }
      @student_stats = @students.map{|student| [student,student.stats(@roster)]}
      render :show_admin
    end
  end
  
  def show_roster_student
    if current_user.class == Professor
      @roster = Roster.find(params[:roster_id])
      @student = User.find(params[:student_id])
      @lessons = @roster.lessons.sort_by { |lesson| lesson.level }
      render :show_roster_student
    end
  end
  
  def new
    if current_user.class == Professor
      @roster = Roster.new
      @all_students = User.all.select{ |user| user.student? }.sort_by{ |student| student.last_name }
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
          format.html {redirect_to roster_path(@roster)}
          format.json {render :json => @roster}
        end
      else
        format.json { render :nothing =>  true }
      end
    end
  end
  
  def add_students
    @roster = Roster.find(params[:id])
    @student_ids = @roster.user_ids
    @student_ids << update_roster_params[:user_ids]
    @student_ids.flatten!
    @roster.update_attributes!({user_ids: @student_ids})
    redirect_to roster_path(@roster)
  end
  
  def remove_student
    @roster = Roster.find(params[:id])
    @student_pending_removal = User.find(params[:user_id])
    @roster.users.delete(@student_pending_removal)
    redirect_to roster_path(@roster)
  end
  
  def get_rosters_by_prof
    @rosters = Professor.find(params[:prof_id]).rosters
    render json: @rosters
  end
  
  private
  
  def roster_params
    params.require(:roster).permit(:title,user_ids: [])
  end
  
  def update_roster_params
    params.require(:roster).permit(:title,user_ids: [],lesson_ids: [])
  end
  
end