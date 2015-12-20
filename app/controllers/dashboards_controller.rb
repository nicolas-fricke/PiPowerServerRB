class DashboardsController < ApplicationController

  # GET /dashboard
  # GET /dashboard.json
  def show
    @entries = DashboardEntry.all
    @available_new_entries =
      PowerOutlet.all + PowerOutletGroup.all - @entries.map(&:item)
  end

  # POST /dashboard
  # POST /dashboard.json
  def create
    DashboardEntry.create(dashboard_entry_params)
    redirect_to :root
  end

  # DELETE /dashboard
  # DELETE /dashboard
  def destroy
    DashboardEntry.find(params[:dashboard_entry][:id]).destroy
    respond_to do |format|
      format.html { redirect_to dashboard_url, notice: 'Entry was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def dashboard_entry_params
      params.require(:dashboard_entry).permit(:item_id, :item_type)
    end
end
