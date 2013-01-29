class EmployementsController < ApplicationController

  load_and_authorize_resource

  # GET /employements
  # GET /employements.json
  def index
    @employements = Employement.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @employements }
    end
  end

  # GET /employements/1
  # GET /employements/1.json
  def show
    @employement = Employement.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @employement }
    end
  end

  # GET /employements/new
  # GET /employements/new.json
  def new
    @employement = Employement.new {{ employee_id: params[:employee_id] }}

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @employement }
    end
  end

  # GET /employements/1/edit
  def edit
    @employement = Employement.find(params[:id])
  end

  # POST /employements
  # POST /employements.json
  def create
    @employement = Employement.new(params[:employement])

    respond_to do |format|
      if @employement.save
        format.html { redirect_to @employement, notice: 'Employement was successfully created.' }
        format.json { render json: @employement, status: :created, location: @employement }
      else
        format.html { render action: "new" }
        format.json { render json: @employement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /employements/1
  # PUT /employements/1.json
  def update
    @employement = Employement.find(params[:id])

    respond_to do |format|
      if @employement.update_attributes(params[:employement])
        format.html { redirect_to @employement, notice: 'Employement was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @employement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employements/1
  # DELETE /employements/1.json
  def destroy
    @employement = Employement.find(params[:id])
    @employement.destroy

    respond_to do |format|
      format.html { redirect_to employements_url }
      format.json { head :no_content }
    end
  end
end
