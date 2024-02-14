resource "aws_s3_bucket" "source" {
  bucket        = format("%s-%s-%s-pipeline", var.cluster_name, var.app_service_name, var.account_id)
  force_destroy = true
}

resource "aws_s3_bucket_ownership_controls" "source_ownership" {
  bucket = aws_s3_bucket.source.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "source_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.source_ownership]

  bucket = aws_s3_bucket.source.id
  acl    = "private"
}
