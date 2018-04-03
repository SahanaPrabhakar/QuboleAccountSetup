resource "aws_s3_bucket" "sparkstoragedemo" {
  bucket = "sparkstoragedemo"
  acl    = "private"

  tags {
    Name        = "sparkstoragedemo"
    Environment = "Qubole"
  }
}

resource "aws_s3_bucket_object" "folder1" {
    bucket = "${aws_s3_bucket.sparkstoragedemo.id}"
    acl    = "private"
    key    = "defloc/"
    source = "emptyfile.txt"
}