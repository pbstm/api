class Photographer < User
  has_many :photo_sessions, dependent: :destroy
end
