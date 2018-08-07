class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
  resp = Faraday.get("https://foursquare.com/oauth2/access_token") do |req|
    req.params['client_id'] = 'DDT25F4P2XNNM4YF4GD2Q0ONFQPP2JPVWV0NP51UHRBWWRJA'
    req.params['client_secret'] = 'WGMYMGQL3TSU4APNXOP353MPZBCTXZKDAEKFPTHSNVAYCOHJ'
    req.params['grant_type'] = 'authorization_code'
    req.params['redirect_uri'] = "http://localhost:3000/auth"
    req.params['code'] = params[:code]
  end

  body = JSON.parse(resp.body)
  session[:token] = body["access_token"]
  redirect_to root_path
end

end
