class <%= resource_class_name_plural %>Controller < ApplicationController
  before_filter :authenticate_user!

  # GET /<%= resource_name_plural %>
  # GET /<%= resource_name_plural %>.json
  def index
    <%= resource_name %>_scope = <%= resource_class_name %>.current
    @order = <%= resource_class_name %>.column_names.collect{|column_name| "<%= resource_name_plural %>.#{column_name}"}.include?(params[:order].to_s.split(' ').first) ? params[:order] : "<%= resource_name_plural %>.name"
    <%= resource_name %>_scope = <%= resource_name %>_scope.order(@order)
    @<%= resource_name_plural %> = <%= resource_name %>_scope.page(params[:page]).per( 20 )

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.json { render json: @<%= resource_name_plural %> }
    end
  end

  # GET /<%= resource_name_plural %>/1
  # GET /<%= resource_name_plural %>/1.json
  def show
    @<%= resource_name %> = <%= resource_class_name %>.current.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @<%= resource_name %> }
    end
  end

  # GET /<%= resource_name_plural %>/new
  # GET /<%= resource_name_plural %>/new.json
  def new
    @<%= resource_name %> = <%= resource_class_name %>.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @<%= resource_name %> }
    end
  end

  # GET /<%= resource_name_plural %>/1/edit
  def edit
    @<%= resource_name %> = <%= resource_class_name %>.current.find(params[:id])
  end

  # POST /<%= resource_name_plural %>
  # POST /<%= resource_name_plural %>.json
  def create
    @<%= resource_name %> = <%= resource_class_name %>.new(post_params)

    respond_to do |format|
      if @<%= resource_name %>.save
        format.html { redirect_to @<%= resource_name %>, notice: '<%= resource_class_name %> was successfully created.' }
        format.json { render json: @<%= resource_name %>, status: :created, location: @<%= resource_name %> }
      else
        format.html { render action: "new" }
        format.json { render json: @<%= resource_name %>.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /<%= resource_name_plural %>/1
  # PUT /<%= resource_name_plural %>/1.json
  def update
    @<%= resource_name %> = <%= resource_class_name %>.current.find(params[:id])

    respond_to do |format|
      if @<%= resource_name %>.update_attributes(post_params)
        format.html { redirect_to @<%= resource_name %>, notice: '<%= resource_class_name %> was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @<%= resource_name %>.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /<%= resource_name_plural %>/1
  # DELETE /<%= resource_name_plural %>/1.json
  def destroy
    @<%= resource_name %> = <%= resource_class_name %>.current.find(params[:id])
    @<%= resource_name %>.destroy

    respond_to do |format|
      format.html { redirect_to <%= resource_name_plural %>_url }
      format.json { head :no_content }
    end
  end

  private

  def parse_date(date_string)
    date_string.to_s.split('/').last.size == 2 ? Date.strptime(date_string, "%m/%d/%y") : Date.strptime(date_string, "%m/%d/%Y") rescue ""
  end

  def post_params
    params[:<%= resource_name %>] ||= {}

    [<%= date_columns.collect{|c| ":#{c.name}"}.join(', ') %>].each do |date|
      params[:<%= resource_name %>][date] = parse_date(params[:<%= resource_name %>][date])
    end

    params[:<%= resource_name %>].slice(
      <%= columns.collect{|c| ":#{c.name}"}.join(', ') %>
    )
  end
end
