eval "$(rbenv init - --no-rehash bash)"

alias ptest="RAILS_ENV=test rake parallel:spec"

# Migrate both local and test DB
function migrate {
  spring stop
  rake db:migrate
  RAILS_ENV=test rake parallel:migrate
}

# Rollback both local and test DB
function rollback {
  spring stop
  rake db:rollback
  RAILS_ENV=test rake parallel:rollback
}
