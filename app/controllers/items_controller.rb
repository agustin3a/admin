class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]


  def iname (type)
     if type == 1 
      name = "Product"
    elsif type == 2
      name = "Service"
    else
      name = "Promo"
    end
    return name
  end

  # GET /items
  # GET /items.json
  def index
    uri = request.env['PATH_INFO']
    if uri == "/products" 
      type = 1
    elsif uri == "/services"
      type = 2
    elsif uri == "/promos"
      type = 3
    else
      @items = Item.all
    end
    @items = Item.where(type: type)
    @name = iname(type)
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @name = iname(@item.type)
    if @item.type == 1 
      @epath = products_edit_path(@item)
    elsif @item.type == 2
      @epath = services_edit_path(@item)
    else
      @epath = promos_edit_path(@item)
    end
      
  end


  # GET /items/new
  def new
    uri = request.env['PATH_INFO']
    if uri == "/products/new" 
      @type = 1
    elsif uri == "/services/new"
      @type = 2
    else
      @type = 3
    end
    @name = iname(@type)
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
    @name = iname(@item.type)
    @type = @item.type
    if @item.type == 1 
      @rpath = "/products"
      @spath = products_show_path(@item)
    elsif @item.type == 2
      @rpath = "/services"
      @spath = services_show_path(@item)
    else
      @rpath = "/promos"
      @spath = promos_show_path(@item)
    end
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)
    respond_to do |format|
      if @item.save
        if @item.type == 1 
          spath = products_show_path(@item)
          notice = 'Product was successfully created.'
        elsif @item.type == 2
          spath = services_show_path(@item)
          notice = 'Service was successfully created.'
        else
          spath = promos_show_path(@item)
          notice = 'Promo was successfully created.'
        end
        format.html { redirect_to spath, notice: notice }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
         if @item.type == 1 
          spath = products_show_path(@item)
          notice = 'Product was successfully updated.'
        elsif @item.type == 2
          spath = services_show_path(@item)
          notice = 'Service was successfully updated.'
        else
          spath = promos_show_path(@item)
          notice = 'Promo was successfully updated.'
        end
        format.html { redirect_to spath, notice: notice }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    if @item.type == 1 
      spath = products_url
      notice = 'Product was successfully destroyed.'
    elsif @item.type == 2
      spath = services_url
      notice = 'Service was successfully destroyed.'
    else
      spath = promos_url
      notice = 'Promo was successfully destroyed.'
    end
    @item.destroy
    respond_to do |format|
      format.html { redirect_to spath, notice: notice }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :description, :type, :price, :initial_date, :expiry_date, :image)
    end
end
