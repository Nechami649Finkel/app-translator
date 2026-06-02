name: Cleanup Lock on Failure
    if: failure()
    run: |
      echo "Terraform failed, cleaning up lock..."
      # פקודה שמוחקת את השורה בטבלת ה-DynamoDB
      aws dynamodb delete-item \
        --table-name terraform-lock-table \
        --key '{"LockID": {"S": "nechami-s3-bucket/terraform.tfstate-md5"}}'
name: Cleanup Lock on Failure
    if: failure()
    run: |
      echo "Terraform failed, cleaning up lock..."
      # פקודה שמוחקת את השורה בטבלת ה-DynamoDB
      aws dynamodb delete-item \
        --table-name terraform-lock-table \
        --key '{"LockID": {"S": "nechami-s3-bucket/terraform.tfstate-md5"}}'
את/ה, עכשיו
# 1. יצירת ה-OAC (ה"מפתח" שמאפשר ל-CloudFront לגשת ל-S3)
resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "s3-oac"
  description                       = "OAC for S3 bucket"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# 2. יצירת ה-Distribution
resource "aws_cloudfront_distribution" "s3_distribution" {
  enabled             = true
  default_root_object = "index.html"

  origin {
    domain_name              = aws_s3_bucket.frontend.bucket_regional_domain_name
    origin_id                = "myS3Origin"
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "myS3Origin"

    viewer_protocol_policy = "redirect-to-https"
    forwarded_values {
      query_string = false
      cookies { forward = "none" }
    }
  }

  restrictions {
    geo_restriction { restriction_type = "none" }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
