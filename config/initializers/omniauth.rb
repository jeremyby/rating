Rails.application.config.middleware.use OmniAuth::Builder do
    provider :twitter, '0ejtn9CgnmYvh7L0mlMtbA', 'lLJmDfyEoOKJAO6FJ8aGzqd9HI3MKOUk4LtW3e5464'
    provider :facebook, '115820318579898', 'b38c09ab8d03cb818ed4fe9c8b01d264'
    provider :google_oauth2, '94758426277', 'ktJAaLLYxe0VfpLpIphKQ577', {access_type: 'online', approval_prompt: ''}
    # Mention other providers here you want to allow user to sign in with
end
