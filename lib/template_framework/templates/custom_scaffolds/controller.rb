class <%= controller_class_name %>Controller < ApplicationController
  before_filter :find_<%= singular_table_name %>, :except => [:index,:new,:create]
  respond_to :html, :json

  def index
    respond_with(@<%= plural_table_name %> = <%= orm_class.all(class_name) %>)
  end

  def show
    respond_with(@<%= singular_table_name %>)
  end

  def new
    respond_with(@<%= singular_table_name %> = <%= orm_class.build(class_name) %>)
  end

  def edit
    respond_with(@<%= singular_table_name %>)
  end

  def create
    respond_with(@<%= singular_table_name %> = <%= class_name %>.create(<%= "params[:#{singular_table_name}]" %>))
  end

  def update
    @<%= orm_instance.update_attributes("params[:#{singular_table_name}]") %>
    respond_with(@<%= singular_table_name %>)
  end

  def destroy
    @<%= orm_instance.destroy %>
    redirect_to <%= index_helper %>_url
  end

private

  def find_<%= singular_table_name %>
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
  end
end
