CarrierWave.configure do |config|

  if Rails.env.development? || Rails.env.test?
    config.storage = :file
  else
    config.storage = :fog
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      =>  'AKIAILGUFTVY67KLZDGQ',
      :aws_secret_access_key  => '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',
      :region                 => 'us-west-1'
    }
    config.fog_directory = 'askac'
  end
end