FROM ruby

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        nodejs postgresql-client \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
ENV RAILS_ENV production

COPY Gemfile* ./
RUN bundle

ADD . /app

EXPOSE 80

ENV RAILS_LOG_TO_STDOUT true
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "80"]

