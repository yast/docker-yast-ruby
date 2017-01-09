FROM opensuse:tumbleweed
RUN zypper ar -f http://download.opensuse.org/repositories/YaST:/Head/openSUSE_Tumbleweed/ yast
RUN zypper --gpg-auto-import-keys --non-interactive in --no-recommends \
  aspell-en \
  fdupes \
  git \
  grep \
  rpm-build \
  update-desktop-files \
  which \
  libxml2-tools \
  libxslt-tools \
  'rubygem(abstract_method)' \
  'rubygem(cfa)' \
  'rubygem(cheetah)' \
  'rubygem(coveralls)' \
  'rubygem(gettext)' \
  'rubygem(raspell)' \
  'rubygem(rspec)' \
  'rubygem(rubocop)' \
  'rubygem(simplecov)' \
  'rubygem(suse-connect)' \
  'rubygem(yard)' \
  'rubygem(yast-rake)' \
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
COPY yast-travis /usr/local/bin/
ENV LC_ALL=en_US.UTF-8
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
# just a smoke test, make sure YaST works
RUN yast2 proxy summary && rm -rf /var/log/YaST2/y2log
