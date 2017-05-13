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

    page_id = params['entry'].first['id']
    page = Page.find_by(facebook_id: page_id.to_i)

    params['entry'].first['changes'].each do |leadgen|
      data = leadgen['value']

      # get form
      graph = Koala::Facebook::API.new(page.access_token)
      form_data = graph.get_object(data['form_id'])
      leadgen_data = graph.get_object(data['leadgen_id'])
      leadgen_data['field_data'] = leadgen_data['field_data'].map do |field|
        [field['name'], field['values'][0]]
      end.to_h
      final_payload = data.merge({form: form_data, lead: leadgen_data})
      HTTPClient.post page.webhook_url, final_payload
    end

    render text: 'ok'
  end

end
