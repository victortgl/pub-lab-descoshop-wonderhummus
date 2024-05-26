provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "dcshp_frontend" {
  bucket = var.default_name
}

resource "aws_s3_bucket_versioning" "dcshp_frontend_versioning" {
  bucket = aws_s3_bucket.dcshp_frontend.bucket
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_website_configuration" "dcshp_frontend_website" {
  bucket = aws_s3_bucket.dcshp_frontend.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_cloudfront_distribution" "dcshp_distribution" {
  origin {
    domain_name = aws_s3_bucket.dcshp_frontend.bucket_regional_domain_name
    origin_id   = var.default_name
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.default_name
    viewer_protocol_policy = "redirect-to-https"
    min_ttl     = 0
    default_ttl = 3600
    max_ttl     = 86400
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Name = var.default_name
  }
}
