class GoodsController < ApplicationController
  before_action :authenticate_user!
  
  def search
    if params[:keyword]
      items = SearchForm.new(keyword: params[:keyword])
      if items.valid?
        @items = RakutenWebService::Ichiba::Item.search(keyword: items.keyword)
      else
        flash.now[:alert] = '入力に誤りがあります。'
        render 'search'
      end
    end
  end
end
