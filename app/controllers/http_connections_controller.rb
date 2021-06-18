#clockifyAPIKEY: MjRmNTM1NmItM2Q5Yy00NmI0LWFkOGUtZmNmM2E2OTgwZjI3
#togglAPIKEY: 0dec30f371f14e15e49b34ca68a09930

class HttpConnectionsController < ApplicationController
  before_action :set_http_connection, only: %i[ show edit update destroy ]

  # GET /http_connections or /http_connections.json
  def index
    @http_connections = HttpConnection.all
  end

  # GET /http_connections/1 or /http_connections/1.json
  def show
  end

  # GET /http_connections/new
  def new
    @http_connection = HttpConnection.new
  end

  # GET /http_connections/1/edit
  def edit
  end
#Chron jobs unix (Run script every x amount of time)
#Use this for my adaptors and gatherin data (Don't miss time, don't be redundant in fetching)
#pass from mongo to sql also with chronjobs
#Mongo db tells me when new data is inserted, and then we pass new stuff to sql
#Mongo and SQL data addition are separate processes
#Background job the datamigration task using redess? background job is an asynchronous request script checks if theres something
#deploy to heroku, use scheduker
#If there is a webhook use it (harder)
  # POST /http_connections or /http_connections.json
  def create
    @http_connection = HttpConnection.new(http_connection_params)
    toggl_api_key = @http_connection.toggl_api
    clockify_api_key = @http_connection.clockify_api
    harvest_account_id = @http_connection.harvest_account_id
    harvest_personal_access_token = @http_connection.harvest_personal_access_token

    @http_connection["toggl_payload"] = toggl_data_request(toggl_api_key)
    @http_connection["clockify_payload"] = clockify_data_request(clockify_api_key)
    @http_connection["harvest_payload"] = harvest_data_request(harvest_account_id, harvest_personal_access_token)

    respond_to do |format|
      if @http_connection.save
        #Do this dumping into the sql database in another method
        sql_data = UserDatum.new
        sql_data["toggl_data"] = @http_connection["toggl_payload"]
        sql_data.save
        format.html { redirect_to @http_connection, notice: "Http connection was successfully created." }
        format.json { render :show, status: :created, location: @http_connection }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @http_connection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /http_connections/1 or /http_connections/1.json
  def update
    respond_to do |format|
      if @http_connection.update(http_connection_params)
        format.html { redirect_to @http_connection, notice: "Http connection was successfully updated." }
        format.json { render :show, status: :ok, location: @http_connection }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @http_connection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /http_connections/1 or /http_connections/1.json
  def destroy
    @http_connection.destroy
    respond_to do |format|
      format.html { redirect_to http_connections_url, notice: "Http connection was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_http_connection
      @http_connection = HttpConnection.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def http_connection_params
      params.require(:http_connection).permit(:toggl_api, :clockify_api, :harvest_api)
    end
end
