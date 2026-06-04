
resource "aws_s3_bucket" "frontend" {
  bucket = "nechami-project-frontend-2026" 
}
resource "aws_s3_bucket_website_configuration" "website_config" {
  bucket = aws_s3_bucket.frontend.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "index.html" 
  }
}
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.frontend.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "allow_cloudfront" {
  bucket = aws_s3_bucket.frontend.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid    = "AllowCloudFrontServicePrincipal"
      Effect = "Allow"
      Principal = { Service = "cloudfront.amazonaws.com" }
      Action   = "s3:GetObject"
      Resource = "${aws_s3_bucket.frontend.arn}/*"
      Condition = {
        StringEquals = { 
          "AWS:SourceArn" = aws_cloudfront_distribution.s3_distribution.arn 
        }
      }
    }]
  })
}