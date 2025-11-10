require 'active_record'

ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: 'db/mydb.sqlite'
)

require_relative 'db/migration/202511061900_change_password_from_user'

ChangePasswordFromUser.migrate(:up)