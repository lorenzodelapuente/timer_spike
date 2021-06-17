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

  # POST /http_connections or /http_connections.json
  def create
    @http_connection = HttpConnection.new(http_connection_params)
    toggl_api = @http_connection.toggl_api

    uri = URI.parse("https://api.track.toggl.com/api/v8/me?with_related_data=true")
    request = Net::HTTP::Get.new(uri)
    request.basic_auth(toggl_api, "api_token")

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
  
    data = JSON.pretty_generate(JSON.parse(response.body))
    @http_connection["payload"] = data

    

    respond_to do |format|
      if @http_connection.save
        sql_data = UserDatum.new
        sql_data.userName = toggl_api
        sql_data.userData = data
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
