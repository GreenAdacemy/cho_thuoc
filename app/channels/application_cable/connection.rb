module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user, :current_uuid

    def connect
      self.current_user = find_verified_user
      self.current_uuid = cookies[:uuid]
    end

    protected

    def find_verified_user
      # reject_unauthorized_connection and return if env['warden'].nil? || env['warden'].user.nil?
      # env['warden'].user
      if (current_user = env["warden"].user)
        current_user
      end
    end
  end
end
