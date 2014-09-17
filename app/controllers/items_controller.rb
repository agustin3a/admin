class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    uri = request.env['PATH_INFO']
    if uri == "/products" 
      @new_path = "products/new"
      @name = "Products"
      @items = Item.where("type = 1")
    elsif uri == "/services"
      @new_path = "services/new"
      @name = "Services"
      @items = Item.where("type = 2")
    else
      @new_path = "promos/new"
      @name = "Promos"
      @items = Item.where("type = 3")
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    if @item.type == 1 
      @rpath = "/products"
      @epath = products_edit_path(@item)
    elsif @item.type == 2
      @rpath = "/services"
      @epath = services_edit_path(@item)
    else
      @rpath = "/promos"
      @epath = promos_edit_path(@item)
    end
      
  end


  # GET /items/new
  def new
    uri = request.env['PATH_INFO']
    if uri == "/products/new" 
      @new_path = "products/new"
      @name = "Product"
      @type = 1
    elsif uri == "/services/new"
      @new_path = "services/new"
      @name = "Service"
      @type = 2
    else
      @new_path = "promos/new"
      @name = "Promo"
      @type = 3
    end
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
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
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
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
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
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
      params.require(:item).permit(:name, :description, :type, :price, :initial_date, :expiry_date)
    end
end
