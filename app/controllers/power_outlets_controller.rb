class PowerOutletsController < ApplicationController
  before_action :set_power_outlet, only: [:show, :edit, :update, :destroy]

  # GET /power_outlets
  # GET /power_outlets.json
  def index
    @power_outlets = PowerOutlet.all
  end

  # GET /power_outlets/1
  # GET /power_outlets/1.json
  def show
  end

  # GET /power_outlets/new
  def new
    @power_outlet = PowerOutlet.new
  end

  # GET /power_outlets/1/edit
  def edit
  end

  # POST /power_outlets
  # POST /power_outlets.json
  def create
    @power_outlet = PowerOutlet.new(power_outlet_params).tap do |outlet|
      outlet.frequency = find_or_create_frequency(frequency_params)
    end
    respond_to do |format|
      if @power_outlet.frequency.save && @power_outlet.save
        format.html { redirect_to @power_outlet, notice: 'Power outlet was successfully created.' }
        format.json { render :show, status: :created, location: @power_outlet }
      else
        format.html { render :new }
        format.json { render json: @power_outlet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /power_outlets/1
  # PATCH/PUT /power_outlets/1.json
  def update
    respond_to do |format|
      if @power_outlet.update(power_outlet_params)
        format.html { redirect_to @power_outlet, notice: 'Power outlet was successfully updated.' }
        format.json { render :show, status: :ok, location: @power_outlet }
      else
        format.html { render :edit }
        format.json { render json: @power_outlet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /power_outlets/1
  # DELETE /power_outlets/1.json
  def destroy
    @power_outlet.destroy
    respond_to do |format|
      format.html { redirect_to power_outlets_url, notice: 'Power outlet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_power_outlet
      @power_outlet = PowerOutlet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def power_outlet_params
      params.require(:power_outlet).permit(:name, :location, :is_on, :frequency_id)
    end

    def frequency_params
      params.require(:frequency).permit(:system_code, :socket_code_human)
    end

    def find_or_create_frequency(params)
      Frequency.find_or_create_by({
        system_code: params[:system_code],
        socket_code: Frequency.socket_code_char_to_i(params[:socket_code_human])
      })
    end
end
