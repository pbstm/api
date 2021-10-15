FROM ruby:3.0.0-alpine

ENV RAILS_ENV production
CMD [ "bundle exec rails s -b 0.0.0.0 -p 3000" ]
WORKDIR /app

RUN apk --no-cache upgrade && \
    apk --no-cache add \
      g++ \
      linux-headers \
      make \
      npm \
      python3 \
      py3-pip \
      \
      imagemagick-dev \
      libressl-dev \
      libxslt-dev \
      readline-dev \
      \
      file \
      git \
      imagemagick \
      less \
      libressl \
      nodejs \
      postgresql-client \
      tzdata \
      yarn && \
    \
    cp /usr/share/zoneinfo/UTC /etc/localtime && \
    \
    npm i -g npm && \
    npm i -g redoc && \
    npm i -g redoc-cli && \
    \
    gem update --system --no-doc && \
    gem install bundler --no-doc && \
    gem cleanup && \
    gem uninstall ostruct && \
    \
    apk del g++ make npm python3 py3-pip linux-headers && \
    cd / && rm -rf /tmp/*

ARG GIT_CREDENTIALS
COPY Gemfile* ./
RUN apk --no-cache add \
      g++ \
      linux-headers \
      make \
      \
      postgresql-dev && \
    \
    bundle install --jobs 12 --retry 5 && \
    \
    apk del linux-headers g++ make postgresql-dev

COPY . .
RUN RAILS_ENV=development \
    rails assets:precompile
