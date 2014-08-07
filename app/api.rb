class API < Grape::API
  format :json
  default_format :json
  
  resource :venues do
    get do
      present Venue.all
    end
  end
  
  resource :shows do
    get do
      present Show.all
    end
  end
  
  resource :events do
    get do
      present Event.upcoming.all
    end
  end
end