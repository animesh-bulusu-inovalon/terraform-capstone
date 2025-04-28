data "terraform_remote_state" "vpc_main" {
    backend = "s3"
    config = {
        bucket = "animeshbulusu-infrastatefiles-apr2025-02"
        key = "02-vpc/02-vpc.tfstate"
        region = "eu-north-1"
    }
}