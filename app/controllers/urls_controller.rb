class UrlsController < ApplicationController
  before_action :authorize

  def index
    @urls = Url.all.paginate(:per_page => 10, :page => params[:page])
  end

  def show
    unless @url = Url.find(params[:id])
      render text: "Page not found", status: "404"
    end
  end

  def new
    @url = Url.new
  end

  def create
    @url = Url.new(url_params)
    respond_to do |format|
       if @url.save
         format.html { redirect_to @url, notice: 'Url was successfully created.' }
         format.json { render :show, status: :created, location: @url }
       else
         format.html { render :new }
         format.json { render json: @url.errors, status: :unprocessable_entity }
       end
     end
  end

  def destroy
    @url = Url.find(params[:id])
    @url.destroy
    redirect_to action: 'index'
  end

  private

  def url_params
    params.require(:url).permit(:url, :name)
  end
end
