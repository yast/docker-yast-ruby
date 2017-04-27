FROM opensuse:42.2
RUN zypper ar -f http://download.opensuse.org/repositories/YaST:/SLE-12:/SP2/SLE_12_SP2/ yast_sle_12_sp2

# we need to install Ruby first to define the %{rb_default_ruby_abi} RPM macro
# see https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#run
# https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#/build-cache
# why we need "zypper clean -a" at the end
RUN zypper --gpg-auto-import-keys --non-interactive in --no-recommends \
  ruby && zypper clean -a

RUN RUBY_VERSION=`rpm --eval '%{rb_default_ruby_abi}'` && \
  zypper --gpg-auto-import-keys --non-interactive in --no-recommends \
  aspell-en \
  fdupes \
  git \
  grep \
  rpm-build \
  update-desktop-files \
  which \
  libxml2-tools \
  libxslt-tools \
  "rubygem($RUBY_VERSION:abstract_method)" \
  "rubygem($RUBY_VERSION:cfa)" \
  "rubygem($RUBY_VERSION:cheetah)" \
  "rubygem($RUBY_VERSION:coveralls)" \
  "rubygem($RUBY_VERSION:gettext)" \
  "rubygem($RUBY_VERSION:raspell)" \
  "rubygem($RUBY_VERSION:rspec)" \
  "rubygem($RUBY_VERSION:rubocop)" \
  "rubygem($RUBY_VERSION:simplecov)" \
  "rubygem($RUBY_VERSION:suse-connect)" \
  "rubygem($RUBY_VERSION:yard)" \
  "rubygem($RUBY_VERSION:yast-rake)" \
  obs-service-source_validator \
  yast2 \
  yast2-add-on \
  yast2-bootloader \
  yast2-core \
  yast2-country \
  yast2-devtools \
  yast2-hardware-detection \
  yast2-inetd \
  yast2-installation \
  yast2-installation-control \
  yast2-ldap \
  yast2-network \
  yast2-nfs-server \
  yast2-packager \
  yast2-pam \
  yast2-perl-bindings \
  yast2-pkg-bindings \
  yast2-proxy \
  yast2-ruby-bindings \
  yast2-samba-client \
  yast2-security \
  yast2-services-manager \
  yast2-slp \
  yast2-storage \
  yast2-testsuite \
  yast2-transfer \
  yast2-update \
  yast2-users \
  yast2-xml \
  yast2-ycp-ui-bindings \
  && zypper clean -a
COPY yast-travis-ruby /usr/local/bin/
ENV LC_ALL=en_US.UTF-8
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
# just some smoke tests, make sure YaST...
RUN TERM=xterm yast2 proxy summary && rm -rf /var/log/YaST2/y2log
# ... and rake work properly
RUN rake -r yast/rake -V
