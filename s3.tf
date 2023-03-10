resource "aws_s3_bucket" "packed_judgment_out" {
  bucket = "${var.env}-${var.prefix}-packed-judgment-out"
}

resource "aws_s3_bucket_policy" "packed_judgment_out" {
  bucket = aws_s3_bucket.packed_judgment_out.bucket
  policy = data.aws_iam_policy_document.judgment_packer_out_bucket.json
}

resource "aws_s3_bucket_acl" "packed_judgment_out" {
  bucket = aws_s3_bucket.packed_judgment_out.id
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "packed_judgment_out" {
  bucket = aws_s3_bucket.packed_judgment_out.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_versioning" "packed_judgment_out" {
  bucket = aws_s3_bucket.packed_judgment_out.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "packed_judgment_out" {
  bucket                  = aws_s3_bucket.packed_judgment_out.bucket
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
