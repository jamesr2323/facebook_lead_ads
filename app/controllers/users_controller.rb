class UsersController < ApplicationController

  def facebook_auth_success

    access_token = request.env['omniauth.auth'].credentials.token
    graph = Koala::Facebook::API.new(access_token)
    pages = graph.get_connections("me", "accounts")

    pages.each do |page_data|
      page = Page.find_or_create_by(facebook_id: page_data['id'].to_i)
      page_attributes = page_data.slice('access_token', 'category', 'name')
      page_attributes['permissions_list'] = page_data['perms'].join(',')
      
      page.update_attributes(page_attributes)
      current_user.pages << page
    end

    redirect_to pages_path
  end
end
