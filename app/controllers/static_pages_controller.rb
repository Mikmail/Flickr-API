class StaticPagesController < ApplicationController
  def home
    flickr = Flickr.new "980b90c301a8865f6819b8e34629210d", "d094e323d01916f7"
    if params[:user_id]
      begin
        @photos = flickr.people.getPublicPhotos(:user_id => params[:user_id], :api_key => ENV['FLICKR_API_KEY'])
      rescue Flickr::FailedResponse
        flash[:alert] = 'User not found'
        @photos = flickr.photos.getRecent(:api_key => ENV['FLICKR_API_KEY'], :per_page => 48)
      end
    else
      @photos = flickr.photos.getRecent(:api_key => ENV['FLICKR_API_KEY'], :per_page => 48)
    end
  end
end