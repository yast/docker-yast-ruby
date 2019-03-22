# SLE15 is officially not available at the Docker Hub
# because of some licensing issues, use openSUSE Leap 15.0 as a replacement.
# It shares the same core packages and should be close enough to SLE15
# for running the YaST tests.
FROM opensuse/leap:15.0

# do not install the files marked as documentation (use "rpm --excludedocs")
RUN sed -i -e "s/^.*rpm.install.excludedocs.*/rpm.install.excludedocs = yes/" /etc/zypp/zypp.conf

# we need to install Ruby first to define the %{rb_default_ruby_abi} RPM macro
# and curl for downloading/installing the GPG key
# see https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#run
# https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#/build-cache
# why we need "zypper clean -a" at the end
RUN zypper --non-interactive in --no-recommends --force-resolution curl ruby && zypper clean -a

# import the YaST OBS GPG key
RUN rpm --import https://build.opensuse.org/projects/YaST/public_key

# Set a higher priority for the yast_sle_12_sp3 repo to prefer the packages from
# this repo even if they have a lower version than the original 42.3 packages.
RUN zypper ar -f -p 95 https://download.opensuse.org/repositories/YaST:/SLE-15:/GA/openSUSE_Leap_15.0 \
  yast_sle15

RUN RUBY_VERSION=ruby:`rpm --eval '%{rb_ver}'` && \
  zypper --non-interactive in --no-recommends --force-resolution \
  aspell-en \
  fdupes \
  git \
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
  "rubygem($RUBY_VERSION:parallel)" \
  "rubygem($RUBY_VERSION:raspell)" \
  "rubygem($RUBY_VERSION:rspec)" \
  "rubygem($RUBY_VERSION:rubocop)" \
  "rubygem($RUBY_VERSION:simplecov)" \
  "rubygem($RUBY_VERSION:simpleidn)" \
  "rubygem($RUBY_VERSION:suse-connect)" \
  "rubygem($RUBY_VERSION:yard)" \
  "rubygem($RUBY_VERSION:yast-rake)" \
  build \
  obs-service-source_validator \
  patterns-rpm-macros \
  yast2 \
  yast2-add-on \
  yast2-bootloader \
  yast2-core \
  yast2-country \
  yast2-devtools \
  yast2-hardware-detection \
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
  yast2-storage-ng \
  yast2-testsuite \
  yast2-transfer \
  yast2-update \
  yast2-users \
  yast2-xml \
  yast2-ycp-ui-bindings \
  && zypper clean -a \
  && rm -rf /usr/lib*/ruby/gems/*/cache/ \
  && rm -rf /usr/share/doc/

COPY yast-travis-ruby /usr/local/bin/
ENV LC_ALL=en_US.UTF-8
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# just some smoke tests, make sure rake and YaST work properly,
# ensure there is no leftover in the working directory
RUN rake -r yast/rake -V && TERM=xterm yast2 proxy summary && \
  rm -rf /var/log/YaST2/y2log && rm -rf /usr/src/app/*
