locals {
  # Static, project-wide metadata
  project     = var.project_name
  environment = var.environment  # e.g. "dev", "staging", "prod"
  managed_by  = "Terraform"

  # A common tags map built from the above
  common_tags = {
    Project     = local.project
    Environment = local.environment
    ManagedBy   = local.managed_by
  }
}