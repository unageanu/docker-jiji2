FROM centos:centos7
MAINTAINER unageanu <masaya.yamauchi@gmail.com>

COPY assets/yum.repos.d/*.repo /etc/yum.repos.d/

RUN yum -y update && yum clean all \
 && yum -y install epel-release; yum clean all \
 && yum -y install mongodb-org monit rbenv git \
    make which wget tar gcc patch readline-devel \
    zlib-devel libyaml-devel libffi-devel openssl-devel \
    gdbm-devel ncurses-devel libxml-devel ImageMagick \
 && yum clean all


# install ruby 2.2.3
ENV RUBY_DIR /ruby
ENV RUBY_VERSION 2.2.3
ENV RUBY_INSTALL $RUBY_DIR/$RUBY_VERSION

RUN mkdir $RUBY_DIR \
 && cd $RUBY_DIR \
 && git clone https://github.com/sstephenson/ruby-build.git \
 && $RUBY_DIR/ruby-build/install.sh \
 && cd $RUBY_DIR/ruby-build \
 && ./bin/ruby-build $RUBY_VERSION $RUBY_INSTALL \
 && rm -rf $RUBY_DIR/ruby-build

ENV PATH $RUBY_INSTALL/bin:$PATH
RUN gem install bundler


# install jiji
ENV APP_DIR /app

RUN mkdir -p $APP_DIR \
 && cd $APP_DIR \
 && git clone https://github.com/unageanu/jiji2.git \
 && cd ./jiji2 \
 && bundle install

RUN mkdir -p /var/run/jiji
RUN ruby -rsecurerandom -e "puts SecureRandom.hex 64" > $APP_DIR/secret

ENV PUMA_DAEMONIZE true
ENV PUMA_APPLICATION_PATH $APP_DIR/jiji2
ENV PORT 80
ENV SECRET `cat $APP_DIR/secret`


# install monit configurations
COPY assets/monit/*.conf /etc/monit.d/
ADD  assets/monit/monitrc /etc/monitrc

RUN chown -R root:root /etc/monit.d/* /etc/monitrc
RUN chmod -R 600 /etc/monit.d/* /etc/monitrc


# install mongodb configurations
ADD  assets/mongodb/mongod.conf /etc/mongod.conf

RUN chown -R root:root /etc/mongod.conf
RUN chmod -R 600 /etc/mongod.conf

VOLUME /data

# mongodb
EXPOSE 27017
# monit
EXPOSE 2812
# jiji
EXPOSE 80

CMD ["/usr/bin/monit", "-I", "-c", "/etc/monitrc"]
