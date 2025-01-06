# frozen_string_literal: true

module CommonController
  extend ActiveSupport::Concern

  included do
    respond_to :html, :json, :js
    before_action do
      @resource_class = resource_class
    end
  end

  def resource_class
    @resource_class ||= controller_name.singularize.camelize.constantize rescue nil
  end

  def index
    authorize! :index, resource_class
    respond_with(collection) do |format|
      format.json { render_datatable }
      format.html
    end
  end

  def render_datatable
  end

  def find_resource
    @resource = collection.find(params[:id])
  end

  def collection
    resource_class.all
  end

  def show
    find_resource
    authorize! :show, @resource
    callback_during_show
    respond_with(@resource)
  end

  def new
    @resource = build_resource
    authorize! :create, @resource
    callback_during_new
    respond_with(@resource)
  end

  def edit
    find_resource
    authorize! :update, @resource
    callback_during_edit
    respond_with(@resource)
  end

  def create
    @resource = build_resource(safe_params)
    authorize! :create, @resource
    callback_before_create
    if @resource.save
      callback_after_create
      respond_with(@resource)
    else
      render :new
    end
  end

  def update
    find_resource
    authorize! :update, @resource
    callback_before_update
    if @resource.update(safe_params)
      callback_after_update
      respond_with(@resource)
    else
      render :edit
    end
  end

  def destroy
    find_resource
    authorize! :destroy, @resource
    if @resource.destroy
      respond_with(@resource)
    else
      redirect_to @resource
    end
  end

  def build_resource(_params = nil)
    collection.new(_params)
  end

  def callback_during_new
  end

  def callback_during_edit
  end

  def callback_after_create
  end

  def callback_after_update
  end

  def callback_before_create
  end

  def callback_before_update
  end

  def callback_during_show
  end

  private

  def safe_params
    params.require(resource_class.name.underscore.to_sym).permit!
  end
end
