
data "template_file" "s3_policy" {
  template = file("s3_policy.json")
  vars = {
    bucket_name = var.static_web_bucket_name
  }
}

resource "aws_s3_bucket" "static_web_bucket" {
  bucket = var.static_web_bucket_name
  acl    = "public-read"
  policy = data.template_file.s3_policy.rendered

  website {
    error_document = "index.html"
    index_document = "index.html"
  }
}

resource "aws_s3_bucket" "artifacts_bucket" {
  bucket        = var.artifacts_bucket_name
  force_destroy = true
}
