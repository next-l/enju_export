class ExportFilesController < ApplicationController
  load_and_authorize_resource

  # GET /export_files
  # GET /export_files.json
  def index
    @export_files = ExportFile.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @export_files }
    end
  end

  # GET /export_files/1
  # GET /export_files/1.json
  def show
    @export_file = ExportFile.find(params[:id])

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

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @export_file }
    end
  end

  # GET /export_files/1/edit
  def edit
    @export_file = ExportFile.find(params[:id])
  end

  # POST /export_files
  # POST /export_files.json
  def create
    @export_file = ExportFile.new(params[:export_file])
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
    @export_file = ExportFile.find(params[:id])

    respond_to do |format|
      if @export_file.update_attributes(params[:export_file])
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
    @export_file = ExportFile.find(params[:id])
    @export_file.destroy

    respond_to do |format|
      format.html { redirect_to export_files_url }
      format.json { head :no_content }
    end
  end
end
