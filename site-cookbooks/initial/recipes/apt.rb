# I'm not really sure these repos will work in 14.04
# Docker in not yet available for i386 (and for ubuntu 14.04)
apt_repository "docker" do
  uri "http://get.docker.io/ubuntu"
  components ["docker", "main"]
  key '36A1D7869245C8950F966E92D8576A8BA88D21E9'
  keyserver 'keyserver.ubuntu.com'
end
apt_repository "chrome" do
  uri "http://dl.google.com/linux/chrome/deb/"
  components ["stable", "main"]
end
apt_repository "google talkplugin" do
  uri "http://dl.google.com/linux/talkplugin/deb/"
  components ["stable", "main"]
end
