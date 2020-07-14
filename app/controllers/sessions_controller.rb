class SessionsController < ApplicationController
  def new
    
  end

  def create
    data = HTTParty.post("https://graph.facebook.com/v1/oauth/access_token",
                        body: {client_id: '1658643664290148',
                        client_secret: '604afb1183cd16715e20c10ce87bb4ff',
                        code: params[:code],
                        grant_type: 'authorization_code',
                        redirect_uri: 'https://calm-thicket-40488.herokuapp.com/sessions/new/'
                        }).parsed_response
    print data
    access_token = data['access_token']
    session[:access_token] = access_token
    session[:user_id] = data['user_id']
    redirect_to posts_path
  end
end
