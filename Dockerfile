# Dockerfile
FROM ruby:3.2.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y postgresql-client build-essential nodejs

# Set working directory
WORKDIR /app

# Install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy application code
COPY . .

# Precompile assets
RUN bundle exec rake assets:precompile

# Set environment variables
ENV RAILS_ENV production
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true

# Expose port
EXPOSE 3000

# Start application
CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]
