resource "aws_s3_bucket_public_access_block" "cloudtrail_block" {
  bucket = aws_s3_bucket.cloudtrail_bucket.id

  block_public_acls       = true // block public access control lists (ACLs) for the bucket
  block_public_policy     = true // block public bucket policies for the bucket
  ignore_public_acls      = true // ignore public ACLs for the bucket
  restrict_public_buckets = true // restrict public bucket policies for the bucket
}

