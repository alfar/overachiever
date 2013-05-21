Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '476506575756141', '972ea119b3f5029fde106866303cd032'
  provider :github, '681cde7a0606b885a15a', '764cabe4f2e9154325860baf56d23a71e80c1f1c'
  provider :google_oauth2, '239078568265', 'gHx4UzKIAs50Gyl_0r2q02cn'
  provider :twitter, 'rhcmnzl5r27S9z7YzXCn2g', 'Mx1vkgwKf9tLwjdTnIKbfzFYogvhUiCnzLKeh6Pd1wo'
end