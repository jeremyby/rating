Rails.application.config.middleware.use OmniAuth::Builder do
    #provider :twitter, 'CONSUMER_KEY', 'CONSUMER_SECRET'
    provider :facebook, '138511299611958', '19b7f263ba8fc18c62143afa9d0dfa81'
    #provider :facebook, '138511299611958', '19b7f263ba8fc18c62143afa9d0dfa81', {:ssl => {:verify => false}}
    # Mention other providers here you want to allow user to sign in with
end
