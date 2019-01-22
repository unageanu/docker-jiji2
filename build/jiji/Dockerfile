FROM ruby:2.3.8
MAINTAINER unageanu <masaya.yamauchi@gmail.com>

# Time Zone
RUN echo "Asia/Tokyo" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

RUN  apt-get update \
	&& apt-get install -y git \
	&& rm -rf /var/lib/apt/lists/*

# install jiji
ENV APP_DIR /app

RUN mkdir -p $APP_DIR \
 && cd $APP_DIR \
 && git clone -b v1.2.0 https://github.com/unageanu/jiji2.git \
 && cd ./jiji2 \
 && bundle install

RUN mkdir -p /var/run/jiji

ENV PUMA_APPLICATION_PATH $APP_DIR/jiji2
ENV PORT 8080
ENV MONGOLAB_URI=mongodb://mongodb:27017/jiji

EXPOSE 8080

CMD [ "puma", "-C", "/app/jiji2/config/puma.rb" ]
