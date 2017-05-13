class FacebookApiController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def webhook
    if accepted_params[:'hub.verify_token'] == ENV['FACEBOOK_HUB_VERIFY_TOKEN']
      render text: accepted_params[:'hub.challenge']
    else
      render text: ''
    end
  end

  def incoming_webhook
    p params
    render text: ''
  end

  private

  def accepted_params
    params.permit(:'hub.challenge', :'hub.verify_token')
  end

end
