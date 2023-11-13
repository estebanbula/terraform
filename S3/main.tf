provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "esteban-dev-bucket" {
  bucket = "esteban-tf-test-bucket"
  tags = {
    Name = "dev-test-bucket"
    Environment = "dev"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "lifecycle_config" {
    bucket = aws_s3_bucket.esteban-dev-bucket.id

    rule {
      id = "lifecyle-rule"
      status = "Enabled"
      expiration {
        days = 1
      }
    }
}

resource "aws_s3_bucket_versioning" "versioning-config" {
    bucket = aws_s3_bucket.esteban-dev-bucket.id

    versioning_configuration {
      status = "Enabled"
    }
  
}