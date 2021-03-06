class CategoriesController < ApplicationController


  def index
    @categories = Category.all
  end

  def show
    @category = Category.find_by( slug: params[:id])
  end

  def new
    @category = Category.new
  end

  def create

    @category = Category.new(category_params)

    if @category.save(category_params)
      flash[:notice] = "Successfully created a category."
      redirect_to root_path
    else
      render :new
    end

  end

  def edit
    @category = Category.find(params[:id])

  end

  def update
    
    @category = Category.find(params[:id])

    if @category.update(category_params)
      flash[:notice] = "Successfully updated category."
      redirect_to root_path
    else
      render :edit
    end

  end

  private

  def category_params
    params.require(:category).permit!
  end

end