class ExportFilesController < ApplicationController
  before_action :set_export_file, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  # GET /export_files
  # GET /export_files.json
  def index
    authorize ExportFile
    @export_files = ExportFile.order('id DESC').page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @export_files }
    end
  end

  # GET /export_files/1
  # GET /export_files/1.json
  def show
    respond_to do |format|
      format.html { # show.html.erb
        if params[:mode] == 'download'
          if @export_file.state == 'completed'
            redirect_to export_file_path(@export_file, :format => :csv)
            #render 'download'
          else
            redirect_to(@export_file, :notice => 'in process')
          end
        end
      }
      format.json { render :json => @export_file }
      format.js
      format.csv {
        if @export_file.state == 'completed'
          if configatron.uploaded_file.storage == :s3
            redirect_to @export_file.export.expiring_url(10)
          else
            send_file @export_file.export.path, :disposition => 'attachment'
          end
        else
          not_found
        end
      }
    end
  end

  # GET /export_files/new
  # GET /export_files/new.json
  def new
    @export_file = ExportFile.new
    authorize @export_file

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @export_file }
    end
  end

  # GET /export_files/1/edit
  def edit
  end

  # POST /export_files
  # POST /export_files.json
  def create
    @export_file = ExportFile.new(export_file_params)
    authorize @export_file
    @export_file.user = current_user

    respond_to do |format|
      if @export_file.save
        format.html { redirect_to @export_file, :notice => ' export file was successfully created.' }
        format.json { render :json => @export_file, :status => :created, location: @export_file }
      else
        format.html { render :action => "new" }
        format.json { render :json => @export_file.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /export_files/1
  # PUT /export_files/1.json
  def update
    respond_to do |format|
      if @export_file.update_attributes(export_file_params)
        format.html { redirect_to @export_file, :notice => ' export file was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @export_file.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /export_files/1
  # DELETE /export_files/1.json
  def destroy
    @export_file.destroy

    respond_to do |format|
      format.html { redirect_to export_files_url }
      format.json { head :no_content }
    end
  end

  private
  def set_export_file
    @export_file = ExportFile.find(params[:id])
    authorize @export_file
  end

  def export_file_params
    params.require(:export_file).permit(
      :export_content_type, :export_file_name, :export_file_size, :state
    )
  end
end
