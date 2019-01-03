class MedicationTimesController < ApplicationController
  before_action :set_medication
  before_action :set_medication_time, only: [:destroy]
  #skip_before_action :verify_authenticity_token, :only => [ :new, :index ]

  # GET /medication_times/new
  def new
    @medication_time = @medication.times.build
    respond_to do |format|
      format.js { render :new }
    end
  end

  # POST /medication_times
  # POST /medication_times.json
  def create
    @medication_time = @medication.times.build(medication_time_params)

    respond_to do |format|
      if @medication_time.save
        format.js { render :create }
        #format.html { redirect_to @medication_time, notice: 'Medication time was successfully created.' }
      else
        format.js { render :new }
        #format.html { render :new }
      end
    end
  end

  # DELETE /medication_times/1
  # DELETE /medication_times/1.json
  def destroy
    @medication_time.destroy
    respond_to do |format|
      format.js { render :destroy }
      #format.html { redirect_to medication_times_url, notice: 'Medication time was successfully destroyed.' }
    end
  end

  private
    def set_medication
      @medication = Medication.find(params[:medication_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_medication_time
      @medication_time = @medication.times.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def medication_time_params
      params.require(:medication_time).permit(:medication_time, :sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :time_of_day)
    end
end
