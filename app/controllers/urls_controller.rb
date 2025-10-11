class UrlsController < ApplicationController
  def new
    @url = Url.new
  end

  def create
    @url = Url.new(url_params)
    if @url.save
      redirect_to @url
    else
      render :new
    end
  end

  def show
    @url = Url.find(params[:id])
  end

  def redirect
    @url = Url.find_by(slug: params[:slug])
    if @url
      @url.increment!(:clicks)
      redirect_to @url.original_url, allow_other_host: true
    else
      redirect_to root_path, alert: "URL not found"
    end
  end

  private

  def url_params
    params.require(:url).permit(:original_url)
  end
end
