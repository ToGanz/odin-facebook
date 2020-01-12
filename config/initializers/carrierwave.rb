if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider:              'AWS',                        # required
      aws_access_key_id:     ENV['AWS_ACCES_KEY_ID'],      # required unless using use_iam_profile
      aws_secret_access_key: ENV['AWS_SECRET_ACCES_KEY']   # required unless using use_iam_profile
    }
    config.storage        = :fog
    config.permissions    = 0666
    config.cache_dir      = "#{Rails.root}/tmp/"
    config.fog_directory  = ENV['FOG_DIRECTORY']                                                # optional, defaults to true
    config.fog_attributes = { cache_control: "max-age=#{365.days.to_i}" } # optional, defaults to {}
  end
end