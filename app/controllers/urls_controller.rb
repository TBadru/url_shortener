class UrlsController < ApplicationController
  def new
    @url = Url.new
  end

def create
  @url = Url.new(url_params)
  if @url.save
    respond_to do |format|
      format.html { redirect_to @url }
      format.json { render json: { short_url: short_url(@url.slug), original_url: @url.original_url }, status: :created }
    end
  else
    respond_to do |format|
      format.html { render :new }
      format.json { render json: { errors: @url.errors.full_messages }, status: :unprocessable_entity }
    end
  end
end


  def show
    @url = Url.find(params[:id])
  end

def redirect
  @url = Url.find_by(slug: params[:slug])
  if @url.nil?
    redirect_to root_path, alert: "URL not found"
  elsif @url.expired?
    redirect_to root_path, alert: "This link has expired"
  else
    @url.increment!(:clicks)
    @url.clicks.create(
      ip_address: request.remote_ip,
      referrer: request.referrer
    )
    redirect_to @url.original_url, allow_other_host: true

    LogClickJob.perform_later(@url.id, request.remote_ip, request.referrer)
redirect_to @url.original_url, allow_other_host: true

  end
end



  private

  def url_params
    params.require(:url).permit(:original_url)
  end
end
