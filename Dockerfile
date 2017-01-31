FROM ruby

ENV TINI_VERSION v0.13.2
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

WORKDIR /usr/src/app
COPY Gemfile /usr/src/app/Gemfile
RUN bundle install
COPY publish-amq-metrics /usr/local/bin

ENTRYPOINT ["/tini", "--", "publish-amq-metrics"]
