FROM jekyll/jekyll

COPY Gemfile .
RUN gem update --system
RUN bundle install --quiet --clean

CMD ["jekyll", "serve"]
