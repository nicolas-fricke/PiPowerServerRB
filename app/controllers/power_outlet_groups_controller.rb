class PowerOutletGroupsController < ApplicationController
  before_action :set_power_outlet_group, only: [:show, :edit, :update, :destroy]

  # GET /power_outlet_groups
  # GET /power_outlet_groups.json
  def index
    @power_outlet_groups = PowerOutletGroup.all
  end

  # GET /power_outlet_groups/1
  # GET /power_outlet_groups/1.json
  def show
  end

  # GET /power_outlet_groups/new
  def new
    @power_outlet_group = PowerOutletGroup.new
  end

  # GET /power_outlet_groups/1/edit
  def edit
  end

  # POST /power_outlet_groups
  # POST /power_outlet_groups.json
  def create
    @power_outlet_group = PowerOutletGroup.new(power_outlet_group_params)

    respond_to do |format|
      if @power_outlet_group.save
        format.html { redirect_to @power_outlet_group, notice: 'Power outlet group was successfully created.' }
        format.json { render :show, status: :created, location: @power_outlet_group }
      else
        format.html { render :new }
        format.json { render json: @power_outlet_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /power_outlet_groups/1
  # PATCH/PUT /power_outlet_groups/1.json
  def update
    respond_to do |format|
      if @power_outlet_group.update(power_outlet_group_params)
        format.html { redirect_to @power_outlet_group, notice: 'Power outlet group was successfully updated.' }
        format.json { render :show, status: :ok, location: @power_outlet_group }
      else
        format.html { render :edit }
        format.json { render json: @power_outlet_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /power_outlet_groups/1
  # DELETE /power_outlet_groups/1.json
  def destroy
    @power_outlet_group.destroy
    respond_to do |format|
      format.html { redirect_to power_outlet_groups_url, notice: 'Power outlet group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_power_outlet_group
      @power_outlet_group = PowerOutletGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def power_outlet_group_params
      params.require(:power_outlet_group).permit(:name, :description, :permalink, :is_on, power_outlet_ids: [])
    end
end
