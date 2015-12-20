class SwitchesController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:update]
  before_action :set_switch_subject, only: [:update]

  # PATCH/PUT /power_outlets/1/switch.json
  def update
    if @switch_subject.update(switch_params)
      render :show, status: :ok, is_on: @switch_subject.is_on, location: @switch_subject
    else
      render json: @switch_subject.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_switch_subject
      @switch_subject = switch_subject_class.find(switch_subject_id)
    end

    def switch_subject_class
      return PowerOutlet if params.key? :power_outlet_id
      return PowerOutletGroup if params.key? :power_outlet_group_id
      nil
    end

    def switch_subject_id
      params.fetch(:power_outlet_id, nil) ||
        params.fetch(:power_outlet_group_id, nil)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def switch_params
      params.permit(:is_on)
    end
end
