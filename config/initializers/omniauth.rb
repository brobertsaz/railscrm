# provider_keys = YAML.load_file(File.join(Rails.root, 'config', 'provider_keys.yml'))

Rails.application.config.middleware.use OmniAuth::Builder do

  provider :identity, model: User,
    on_failed_registration: lambda { |env| UsersController.action(:new).call(env) }
end
