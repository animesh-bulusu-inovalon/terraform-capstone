terraform {
  backend "s3" {
    bucket       = "animeshbulusu-infrastatefiles-apr2025-02"
    key          = "03-load-balancer/03-load-balancer.tfstate"
    use_lockfile = true
    region       = "eu-north-1"
  }
}