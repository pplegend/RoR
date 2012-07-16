class ProductsController < ApplicationController
  # GET /products
  # GET /products.xml
  def index
    @category=Category.find(params[:category_id])
    @products = @category.products
    @title="Products list"
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @products }
    end
  end
  #GET random products

  def home_page
   @products=Product.all
   @title="Home"
  end
  # GET /products/1
  # GET /products/1.xml
  def show
    @product = Product.find(params[:id])
    categories_id=[]
    @related_products=[]
    categories=@product.categories
    categories.each do |category|
      for product in category.products
        @related_products << product
      end
      
    end 
    @related_products=@related_products.uniq{|product| product.id}

    @comments=@product.comments.paginate(:page=> params[:page],:per_page=>6)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/new
  # GET /products/new.xml
  def new
    @product = Product.new
    @categories=Category.all
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
    @categories=Category.all
  end

  # POST /products
  # POST /products.xml
  def create
    @product = Product.new(params[:product])
    @categories=Category.find(params[:category_ids])
    
   # @product.categories.create
    respond_to do |format|
      if @product.save
	       @product.categories=@categories
        format.html { redirect_to(@product, :notice => 'Product was successfully created.') }
        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.xml
  def update
    @product = Product.find(params[:id])
    @categories=Category.find(params[:category_ids])
    respond_to do |format|
      if @product.update_attributes(params[:product])
         @product.categories=@categories
        format.html { redirect_to(@product, :notice => 'Product was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.xml
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to(products_url) }
      format.xml  { head :ok }
    end
  end
  
  def search
     @products=Product.search params[:search]
     #@products<< Product.tagged_with([params[:search]])

  end
 
end
