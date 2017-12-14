class PositionsController < BaseController
  before_action :find_position, only: [:show, :edit, :update, :destroy]
  def index
    @positions = Position.all
  end

  def new
    @position = Position.new
  end

  def show
  end

  def create
    @position = Position.new(position_params)
    if @position.save
      redirect_to @position
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @position.update(position_params)
      redirect_to @position
    else
      render :edit
    end
  end

  def destroy
    @position.destroy
    redirect_to positions_path
  end

  private

  def position_params
    params.require(:position).permit(:title, :description)
  end

  def find_position
    @position = Position.find(params[:id])
  end
end
