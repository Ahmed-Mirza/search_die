class SearchContentsController < ApplicationController
  @@content=""
  def search_page
    @search_content=SearchContent.new
  end
  
  def store_history
    @search_content=SearchContent.new(params[:search_content])
    if @search_content.save
      redirect_to results_path, :notice => "Your Search has been Saved"
      @@content=@search_content
    else
      render "search_page"
    end
  end
  
  def history_page
    @search_contents=SearchContent.all    
  end
  
  def results_page
    require 'oauth'
    require 'json'
    api_key = "3ny3q0g0dq0m"
    api_secret="0uofVVUTKxWO7jim"
    user_token="83a65c8f-ae45-4cdb-8ebe-09d6c55c4c1f"
    user_secret="c9dc334a-348c-49a4-9eb7-33a862894332"
    
    # Specify LinkedIn API endpoint
    consumer_options = { :site => "https://api.linkedin.com",
                     :authorize_path => "/uas/oauth/requestToken",
                     :request_token_path => "/uas/oauth/accessToken",
                     :access_token_path => "/uas/oauth/authorize" }
    
    # Use your API key and secret to instantiate consumer object
    consumer = OAuth::Consumer.new(api_key, api_secret, consumer_options)
    
    # Use your developer token and secret to instantiate access token object
    access_token = OAuth::AccessToken.new(consumer, user_token, user_secret)
    
    # Make a request for JSON data
    @json_txt = access_token.get("/v1/people-search?keywords=#{@@content}", 'x-li-format' => 'json').body
    @profile = JSON.parse(@json_txt)
  end
  
end
