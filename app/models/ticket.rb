class Ticket < ApplicationRecord
  belongs_to :event

  def salt
    Digest::SHA256.hexdigest(user_info.to_json)[0..12]
  end

  def verify(salt)
    self.salt == salt
  end
end
