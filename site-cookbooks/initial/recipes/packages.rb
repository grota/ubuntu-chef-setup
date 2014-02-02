my_packages = %w{
tmux ikiwiki libtext-markdown-perl libtext-multimarkdown-perl libhighlight-perl
libxml-writer-perl postfix mutt-patched libgnutls-dev libfaad-dev libmad0-dev
libao-dev openssh-server tig git gitk xclip xdotool xbindkeys jq colordiff
wdiff sysstat atop iotop dstat htop nethogs exuberant-ctags mplayer2 youtube-dl
aptitude compizconfig-settings-manager gnome-tweak-tool mplayer2
transmission-gtk gtk2-engines-pixbuf indicator-multiload cabextract dconf-tools
vim-gnome alarm-clock-applet lm-sensors hddtemp psensor pbzip2 tree
openjdk-7-jdk ant hamster-indicator ccache sqlitebrowser lftp xapian-omega
libsearch-xapian-perl libdigest-sha-perl libhtml-scrubber-perl rake
libreadline-dev build-essential libyaml-dev libsqlite3-dev sqlite3
libxslt-dev ncurses-dev bison libgdbm-dev libffi-dev moreutils
}
# Packages that `seem` to be problematic in ubuntu 14.04
# meld

my_packages.each do |pkg|
  package pkg
end
