parse_git_branch() {
 git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(git::\1)/'
}
parse_svn_branch() {
  parse_svn_url | sed -e 's#^'"$(parse_svn_repository_root)"'##g' | awk -F / '{print "(svn::"$1 "/" $2 ")"}'
}
parse_svn_url() {
  svn info 2>/dev/null | grep -e '^URL*' | sed -e 's#^URL: *\(.*\)#\1#g '
}
parse_svn_repository_root() {
  svn info 2>/dev/null | grep -e '^Repository Root:*' | sed -e 's#^Repository Root: *\(.*\)#\1\/#g '
}
export PS1="\[\033[00m\]\u@\h\[\033[01;34m\] \w \[\033[31m\]\$(parse_git_branch)\$(parse_svn_branch) \[\033[00m\]$\[\033[00m\] "

alias psql_stop='pg_ctl -D /usr/local/var/postgres -m fast stop'
alias psql_start='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias redis_start='redis-server /usr/local/etc/redis.conf&'
alias lenv='source /usr/local/bin/load_env.sh'

export EDITOR=vim

if [ -f ~/.git-completetion.bash ]; then
  .~/.git-completetion.bash
fi

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
