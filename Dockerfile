FROM ruby:2.6.5

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

RUN apt-get update -qq && \
    apt-get install -y nodejs \
                       npm && \
    npm install -g yarn
    
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs yarn

WORKDIR /Musclenutri

ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn

COPY Gemfile ./Gemfile
COPY Gemfile.lock ./Gemfile.lock

RUN gem install bundler
RUN bundle install

COPY . /Musclenutri
COPY entrypoint.sh /usr/bin/

RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]