class Stream < ActiveRecord::Base
  before_create do |stream|
    session = OpenTokClient.create_session
    stream.tokbox_session_id = session.session_id
  end

  belongs_to :user
end
