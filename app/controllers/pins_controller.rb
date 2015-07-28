class PinsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @pins = Pin.all
  end

  def show
    @pin = Pin.find(params[:id])
  end

  def new
    @pin = current_user.pins.build
  end

  def edit
    @pin = Pin.find(params[:id])
  end

  def create
    @pin = current_user.pins.build(pin_params)


    if @pin.save
      redirect_to @pin, notice: 'Pin was successfully created.'
    else
      render :new  
    end
  end

  def update
    @pin = Pin.find(params[:id])
    if @pin.update(pin_params)
      redirect_to @pin, notice: 'Pin was successfully updated.'
    else
      render :edit
    end
  end


  def destroy
    @pin = Pin.find(params[:id])
    @pin.destroy
    redirect_to pins_url, notice: 'Pin was successfully deleted.'
  end

  private

    def correct_user
      @pin = current_user.pins.find_by(id: params[:id])
      redirect_to pins_path, notice: "Not authorized to edit this pin" if @pin.nil?
    end

    def pin_params
      params.require(:pin).permit(:description, :image)
    end
end
