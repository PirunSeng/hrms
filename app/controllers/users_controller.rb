class UsersController < BaseController
  before_action :find_employee, only: [:show, :edit, :update, :destroy]
  before_action :find_positions, :find_departments

  def index
    @employees = User.all
  end

  def new
    @employee = User.new
  end

  def show
  end

  def create
    @employee = User.new(employee_params)
    if @employee.save
      redirect_to @employee
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @employee.update(employee_params)
      redirect_to @employee
    else
      render :edit
    end
  end

  def destroy
    @employee.destroy
    redirect_to users_path
  end

  private

  def employee_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :phone, :salary, :address, :performance, :start_date, :position_id, :department_id)
  end

  def find_employee
    @employee = User.find(params[:id])
  end

  def find_positions
    @positions = Position.order(:title)
  end

  def find_departments
    @departments = Department.order(:name)
  end
end
