resource "aws_s3_bucket" "app" {
  bucket = "ror-app-${random_id.bucket_suffix.hex}"
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Name = "ror-app-bucket"
  }
}

resource "random_id" "bucket_suffix" {
  byte_length = 8
}
