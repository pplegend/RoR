class CommentsController < ApplicationController
  def index
   @product=Product.find(params[:product_id])
    @comments = @product.comments.paginate(:page=> params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  def create
      @product=Product.find(params[:product_id])
    respond_to do |format|
      if @comment=@product.comments.create!(params[:comment])
        format.html { redirect_to(@product, :notice => 'Comment was successfully created.') }
        format.xml  { render :xml => @product, :status => :created, :location => @product }
        format.js 
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
  end

end
