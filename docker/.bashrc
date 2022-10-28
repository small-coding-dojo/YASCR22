git config --global user.email "yascr22@example.com"
git config --global user.name $(printenv K_SERVICE)

[ ! -d "$HOME/yascrtest" ] && git clone git@github.com:small-coding-dojo/yascrtest.git "$HOME/yascrtest"
