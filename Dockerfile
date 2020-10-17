FROM ruby:2.7.1

RUN apt-get update -qq && apt-get install -y postgresql-client
RUN gem install bundler

ENV APP_HOME /url_shortener
RUN mkdir $APP_HOME
WORKDIR $APP_HOME


ADD Gemfile* $APP_HOME/
ADD Gemfile.lock* $APP_HOME/

RUN apt-get update

ADD . $APP_HOME

EXPOSE 8080

ENTRYPOINT ["./docker_entrypoint"]
