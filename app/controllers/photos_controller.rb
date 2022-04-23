require 'uri'
require 'net/http'
require 'openssl'

class PhotosController < ApplicationController
  def index
    @photos = Photo.where(user: current_user).order(created_at: :desc)
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.user = current_user

    if @photo.save
      redirect_to photos_path
    else
      render :new
    end
  end

  def authorize_tweet
    client_id = ENV['CLIENT_ID']
    redirect_uri = "http://localhost:3000/oauth/callback"
    redirect_to "https://arcane-ravine-29792.herokuapp.com/oauth/authorize?response_type=code&client_id=#{client_id}&redirect_uri=#{redirect_uri}"
  end

  def callback
    session[:code] = params[:code]
    request_access_token

    redirect_to photos_path
  end

  def send_tweet
    create_tweet
  end

  private

  def photo_params
    params.require(:photo).permit(:title, :image)
  end

  def request_access_token
    @code = session[:code]

    client_id = ENV['CLIENT_ID']
    redirect_uri = "http://localhost:3000/oauth/callback"
    key = "Bearer #{ENV['CLIENT_SECRET']}"

    url = URI("https://arcane-ravine-29792.herokuapp.com/oauth/token?grant_type=authorization_code&code=#{@code}&client_id=#{client_id}&redirect_uri=#{redirect_uri}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["Accept"] = 'application/json'
    request["Content-Type"] = 'application/json'
    request["Authorization"] = key
    request.body = "{\"text\":\"\",\"url\":\"http://localhost:3000/photos/#{params[:photo]}.jpg\"}"
    response = http.request(request)
    body = JSON.parse(response.read_body)

    session[:access_token] = body['access_token']
  end

  def create_tweet
    key = "Bearer #{session[:access_token]}"
    url = URI("https://arcane-ravine-29792.herokuapp.com/api/tweets")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["Accept"] = 'application/json'
    request["Content-Type"] = 'application/json'
    request["Authorization"] = key
    request.body = "{\"text\":\"テスト画像\",\"url\":\"http://localhost:3000/photos/#{params[:photo]}\"}"

    response = http.request(request)
    body = JSON.parse(response.read_body)
  
    if response.is_a?(Net::HTTPCreated)
      flash[:notice] = "ツイートを作成しました。"
      redirect_to photos_path
    end
  end
end
