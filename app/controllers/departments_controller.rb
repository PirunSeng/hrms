class DepartmentsController < BaseController
  before_action :find_department, only: [:show, :edit, :update, :destroy]
  def index
    @departments = Department.all
  end

  def new
    @department = Department.new
  end

  def show
  end

  def create
    @department = Department.new(department_params)
    if @department.save
      redirect_to @department
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @department.update(department_params)
      redirect_to @department
    else
      render :edit
    end
  end

  def destroy
    @department.destroy
    redirect_to departments_path
  end

  private

  def department_params
    params.require(:department).permit(:name, :description)
  end

  def find_department
    @department = Department.find(params[:id])
  end
end
