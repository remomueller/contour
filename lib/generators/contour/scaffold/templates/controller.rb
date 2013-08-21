class <%= resource_class_name_plural %>Controller < ApplicationController
  before_action :authenticate_user!
  before_action :set_<%= resource_name %>, only: [ :show, :edit, :update, :destroy ]

  # GET /<%= resource_name_plural %>
  # GET /<%= resource_name_plural %>.json
  def index
    @order = scrub_order(<%= resource_class_name %>, params[:order], "<%= resource_name_plural %>.name")
    @<%= resource_name_plural %> = <%= resource_class_name %>.current.order(@order).page(params[:page]).per( 20 )
  end

  # GET /<%= resource_name_plural %>/1
  # GET /<%= resource_name_plural %>/1.json
  def show
  end

  # GET /<%= resource_name_plural %>/new
  def new
    @<%= resource_name %> = <%= resource_class_name %>.new
  end

  # GET /<%= resource_name_plural %>/1/edit
  def edit
  end

  # POST /<%= resource_name_plural %>
  # POST /<%= resource_name_plural %>.json
  def create
    @<%= resource_name %> = <%= resource_class_name %>.new(<%= resource_name %>_params)

    respond_to do |format|
      if @<%= resource_name %>.save
        format.html { redirect_to @<%= resource_name %>, notice: '<%= resource_class_name %> was successfully created.' }
        format.json { render action: 'show', status: :created, location: @<%= resource_name %> }
      else
        format.html { render action: 'new' }
        format.json { render json: @<%= resource_name %>.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /<%= resource_name_plural %>/1
  # PUT /<%= resource_name_plural %>/1.json
  def update
    respond_to do |format|
      if @<%= resource_name %>.update(<%= resource_name %>_params)
        format.html { redirect_to @<%= resource_name %>, notice: '<%= resource_class_name %> was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @<%= resource_name %>.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /<%= resource_name_plural %>/1
  # DELETE /<%= resource_name_plural %>/1.json
  def destroy
    @<%= resource_name %>.destroy

    respond_to do |format|
      format.html { redirect_to <%= resource_name_plural %>_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_<%= resource_name %>
      @<%= resource_name %> = <%= resource_class_name %>.current.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def <%= resource_name %>_params
      params[:<%= resource_name %>] ||= {}

      [<%= date_columns.collect{|c| ":#{c.name}"}.join(', ') %>].each do |date|
        params[:<%= resource_name %>][date] = parse_date(params[:<%= resource_name %>][date])
      end

      params.require(:<%= resource_name %>).permit(<%= columns.collect{|c| ":#{c.name}"}.join(', ') %>)
    end

    # Scrub order and parse_date can be moved to your ApplicationController
    def scrub_order(model, params_order, default_order)
      (params_column, params_direction) = params_order.to_s.strip.downcase.split(' ')
      direction = (params_direction == 'desc' ? 'DESC' : nil)
      column_name = (model.column_names.collect{|c| model.table_name + "." + c}.select{|c| c == params_column}.first)
      order = column_name.blank? ? default_order : [column_name, direction].compact.join(' ')
      order
    end

    def parse_date(date_string, default_date = '')
      date_string.to_s.split('/').last.size == 2 ? Date.strptime(date_string, "%m/%d/%y") : Date.strptime(date_string, "%m/%d/%Y") rescue default_date
    end
end
