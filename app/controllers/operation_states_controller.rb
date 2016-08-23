class OperationStatesController < ApplicationController
  before_action :set_operation_state, only: [:show, :edit, :update, :destroy]

  # GET /operation_states
  # GET /operation_states.json
  def index
    @operation_states = OperationState.all
  end

  # GET /operation_states/1
  # GET /operation_states/1.json
  def show
  end

  # GET /operation_states/new
  def new
    @operation_state = OperationState.new
  end

  # GET /operation_states/1/edit
  def edit
  end

  # POST /operation_states
  # POST /operation_states.json
  def create
    @operation_state = OperationState.new(operation_state_params)

    respond_to do |format|
      if @operation_state.save
        format.html { redirect_to @operation_state, notice: 'Operation state was successfully created.' }
        format.json { render :show, status: :created, location: @operation_state }
      else
        format.html { render :new }
        format.json { render json: @operation_state.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /operation_states/1
  # PATCH/PUT /operation_states/1.json
  def update
    respond_to do |format|
      if @operation_state.update(operation_state_params)
        format.html { redirect_to @operation_state, notice: 'Operation state was successfully updated.' }
        format.json { render :show, status: :ok, location: @operation_state }
      else
        format.html { render :edit }
        format.json { render json: @operation_state.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /operation_states/1
  # DELETE /operation_states/1.json
  def destroy
    @operation_state.destroy
    respond_to do |format|
      format.html { redirect_to operation_states_url, notice: 'Operation state was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_operation_state
      @operation_state = OperationState.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def operation_state_params
      params.require(:operation_state).permit(:name)
    end
end
