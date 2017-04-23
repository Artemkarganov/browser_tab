class User < ApplicationRecord

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.save!
    end
  end

  def self.friends(current_user)
    graph = Koala::Facebook::API.new(current_user.oauth_token)
    user_friends = graph.get_connections(current_user.uid, 'friends')

    uids = []
    user_friends.each { |f| uids << f['id'] }

    where('uid IN (?)', uids)
  end

  has_many :urls
end
