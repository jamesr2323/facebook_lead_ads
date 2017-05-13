class FacebookApiController < ApplicationController

  def webhook
    if accepted_params[:'hub.verify_token'] == ENV['FACEBOOK_HUB_VERIFY_TOKEN']
      render text: accepted_params[:'hub.challenge']
    else
      render text: ''
    end
  end

  def incoming_webhook
    render text: ''
  end

  private

  def accepted_params
    params.permit(:'hub.challenge', :'hub.verify_token')
  end

end
