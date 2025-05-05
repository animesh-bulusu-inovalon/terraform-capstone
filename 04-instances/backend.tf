terraform {
  backend "s3" {
    bucket       = "animeshbulusu-infrastatefiles-apr2025-02"
    key          = "04-instances/04-instances.tfstate"
    use_lockfile = true
    region       = "eu-north-1"
  }
}