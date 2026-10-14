if command -v rbenv &>/dev/null; then
  eval "$(rbenv init - --no-rehash zsh)"

  alias ptest="RAILS_ENV=test rake parallel:spec"

  # Migrate both local and test DB
  migrate() {
    spring stop
    rake db:migrate
    RAILS_ENV=test rake parallel:migrate
  }

  # Rollback both local and test DB
  rollback() {
    spring stop
    rake db:rollback
    RAILS_ENV=test rake parallel:rollback
  }
fi
