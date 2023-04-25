# use apt-source package which contains keyring
curl -o td-agent-apt-source.deb https://packages.treasuredata.com/4/debian/bullseye/pool/contrib/f/fluentd-apt-source/fluentd-apt-source_2020.8.25-1_all.deb &&
apt install -y ./td-agent-apt-source.deb

# update your sources
apt update

# install the toolbelt
apt install -y td-agent
