resource "aws_s3_bucket" "sparkstoragedemo" {
  bucket = "sparkstoragedemo"
  acl    = "private"

  tags {
    Name        = "sparkstoragedemo"
    Environment = "Qubole"
  }
}