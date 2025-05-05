data "terraform_remote_state" "networking_layer" {
  backend = "s3"
  config = {
    bucket = "animeshbulusu-infrastatefiles-apr2025-02"
    key    = "02-networking/02-networking.tfstate"
    region = "eu-north-1"
  }
}

data "terraform_remote_state" "alb_layer" {
  backend = "s3"
  config = {
    bucket = "animeshbulusu-infrastatefiles-apr2025-02"
    key    = "03-load-balancer/03-load-balancer.tfstate"
    region = "eu-north-1"
  }
}