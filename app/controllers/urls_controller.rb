class UrlsController < ApplicationController

  before_filter :authorize

  def index
    @urls = Url.all
    if params[:search]
      @urls = Url.search(params[:search]).paginate(:per_page => 10, :page => params[:page])
    else
      @urls = Url.all.paginate(:per_page => 10, :page => params[:page])
    end
  end

  def show
    unless @url = current_user.urls.find(params[:id])
      render text: "Page not found", status: "404"
    end
  end

  def new
    @url = current_user.urls.new
  end

  def create
    @url = current_user.urls.new(url_params)
    respond_to do |format|
       if @url.save
         a = rand(36**11).to_s(36).upcase[0,6]
         screenshot = Gastly.screenshot(@url.url, timeout: 1000)
         image = screenshot.capture
         image.resize(width: 110, height: 110)
         image.format('jpg')
         image.save(Rails.root + 'app/assets/images' + a)
         @url.image = a
         @url.save
         format.html { redirect_to @url, notice: 'Url was successfully created.' }
         format.json { render :show, status: :created, location: @url }
       else
         format.html { render :new }
         format.json { render json: @url.errors, status: :unprocessable_entity }
       end
     end
  end

  def destroy
    @url = current_user.urls.find(params[:id])
    @url.destroy
    redirect_to action: 'index'
  end

  private

  def url_params
    params.require(:url).permit(:url, :name)
  end
  helper_method :urls
end
