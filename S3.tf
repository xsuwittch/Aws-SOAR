
/*

We will skip cloud trail for now, as it is not needed for the initial deployment of the SOAR platform.

resource "aws_s3_bucket" "cloudtrail_bucket" {
    bucket = "soar-cloudtrail-bucket"

}
*/
resource "aws_s3_bucket" "Vpc_bucket" {
    bucket = "soar-vpc-bucket"
    
}
