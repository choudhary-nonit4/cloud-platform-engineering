variable "environment" {
    type = string
    validation {
        condition = contains(["dev", "qa", "prod"], var.environment)
        error_message = "Environment must be dev, qa or prod"
    }
    project_name = "cloud-project"
}