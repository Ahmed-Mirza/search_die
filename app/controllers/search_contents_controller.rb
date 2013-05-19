class SearchContentsController < ApplicationController
  
  def search_page
    @search_content=SearchContent.new
  end
  
  def store_history
    @search_content=SearchContent.new(params[:search_content])
    if @search_content.save
      redirect_to results_path, :notice => "Your Search has been Saved"
    else
      render "search_page"
    end
  end
  
  def history_page
    @search_contents=SearchContent.all    
  end
  
end
