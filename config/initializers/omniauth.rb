Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'], scope: 'email,ads_management,manage_pages', client_options: {
      site: 'https://graph.facebook.com/v2.8',
      authorize_url: "https://www.facebook.com/v2.8/dialog/oauth"
    }
end