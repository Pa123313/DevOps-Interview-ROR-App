provider "aws" {
  region = "eu-north-1"
}

# Create an S3 bucket to store static files
resource "aws_s3_bucket" "my_ruby_app_bucket" {
  bucket = "my-ruby-app-bucket"
}


