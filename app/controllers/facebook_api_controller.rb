class FacebookApiController < ApplicationController

  def webhook
    if accepted_params[:hub_verify_token] == ENV['FACEBOOK_HUB_VERIFY_TOKEN']
      render text: accepted_params[:hub_verify_challenge]
    else
      render text: ''
    end
  end

  private

  def accepted_params
    params.permit(:hub_verify_challenge, :hub_verify_token)
  end

end
