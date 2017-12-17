class ApplicantsController < BaseController
  before_action :find_applicant, only: [:show, :edit, :update, :destroy]
  def index
    @applicants = Applicant.all
  end

  def new
    @applicant = Applicant.new
  end

  def show
  end

  def create
    @applicant = Applicant.new(applicant_params)
    if @applicant.save
      redirect_to @applicant
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @applicant.update(applicant_params)
      redirect_to @applicant
    else
      render :edit
    end
  end

  def destroy
    @applicant.destroy
    redirect_to applicants_path
  end

  private

  def applicant_params
    params.require(:applicant).permit(:name, :email, :phone, :interview_status, :interview_date, :interview_result, :invitation_status)
  end

  def find_applicant
    @applicant = Applicant.find(params[:id])
  end
end
