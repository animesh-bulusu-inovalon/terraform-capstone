terraform {
  backend "s3" {
    bucket       = "animeshbulusu-infrastatefiles-apr2025-02"
    key          = "01-terraform-init/01-terraform-init.tfstate"
    use_lockfile = true
    region       = "eu-north-1"
  }
}