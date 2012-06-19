class ReportsController < ApplicationController

  skip_before_filter :authenticate, :only => [:new, :edit, :update, :create]
  before_filter :authenticate_user!, :only => [:new, :edit, :update, :create]

  # GET /reports
  # GET /reports.json
  def index
    if current_admin
      @users = User.approved.includes(:reports)
      @min_year = Report.minimum('year')||6.year.ago.year
      @max_year = Report.maximum('year')||1.year.ago.year
      respond_to do |format|
        format.html # index.html.erb
        format.json { render :json => @reports }
      end
    elsif current_user
      redirect_to current_user
      #redirect user to user page
    end
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
    @report = Report.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @report }
    end
  end

  # GET /reports/new
  # GET /reports/new.json
  def new
    @report = Report.new(:user_id => current_user.id)

    @report.uploaded_exports.build(:file_type => FileTypes::EXPORT)
    @report.uploaded_imports.build(:file_type => FileTypes::IMPORT)
    @report.uploaded_additional_information.build(:file_type => FileTypes::ADDITIONAL_INFORMATION)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @report }
    end
  end

  # GET /reports/1/edit
  def edit
    @report = Report.find(params[:id])
    @report.uploaded_exports.build(:file_type => FileTypes::EXPORT) if !@report.uploaded_exports.any?
    @report.uploaded_imports.build(:file_type => FileTypes::IMPORT) if !@report.uploaded_imports.any?
    @report.uploaded_additional_information.build(:file_type => FileTypes::ADDITIONAL_INFORMATION) if !@report.uploaded_additional_information.any?
  end

  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new(params[:report])
    @report.user = current_user

    respond_to do |format|
      if @report.save
        ReportMailer.report_submitted(@report).deliver
        ReportMailer.report_submitted_admin(@report).deliver
        format.html { redirect_to @report, :notice => I18n.t('flash.rep_created') }
        format.json { render :json => @report, :status => :created, :location => @report }
      else
        format.html { render :action => "new" }
        format.json { render :json => @report.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /reports/1
  # PUT /reports/1.json
  def update
    @report = Report.find(params[:id])

    respond_to do |format|
      if @report.update_attributes(params[:report])
        format.html { redirect_to @report, :notice => 'Report was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @report.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report = Report.find(params[:id])
    @report.destroy

    respond_to do |format|
      format.html { redirect_to reports_url }
      format.json { head :ok }
    end
  end
end
