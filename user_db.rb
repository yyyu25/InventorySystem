require 'json'
require 'bcrypt'
require 'time'

class UserDB
  FILE_PATH = 'users.json'

  def initialize
    if File.exist?(FILE_PATH)
      @users = JSON.parse(File.read(FILE_PATH))
    else
      @users = {}
      save
    end
  end

  def save
    File.write(FILE_PATH, JSON.pretty_generate(@users))
  end

  def create_user(username, password)
    username = username.to_s
    return false if username.empty? || password.to_s.empty? || @users.key?(username)

    @users[username] = {
      "password_hash" => BCrypt::Password.create(password),
      "created_at"    => Time.now.utc.iso8601
    }
    save
    true
  end

  def authenticate(username, password)
    username = username.to_s
    return false unless @users.key?(username)

    stored_hash = @users[username]["password_hash"]
    BCrypt::Password.new(stored_hash) == password
  end

  def exists?(username)
    @users.key?(username.to_s)
  end
end
