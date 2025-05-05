data "terraform_remote_state" "networking_layer" {
  backend = "s3"
  config = {
    bucket = "animeshbulusu-infrastatefiles-apr2025-02"
    key    = "02-networking/02-networking.tfstate"
    region = "eu-north-1"
  }
}