terraform {
  backend "s3" {
    bucket       = "animeshbulusu-infrastatefiles-apr2025-02"
    key          = "02-networking/02-networking.tfstate"
    use_lockfile = true
    region       = "eu-north-1"
  }
}