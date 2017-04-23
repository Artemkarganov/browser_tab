OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '744989285662763', '9f3fba07858a2bf091cd0d5f760f4d20', scope: 'user_friends'
end
