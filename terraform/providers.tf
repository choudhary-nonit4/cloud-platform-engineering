provider "aws" {
    region = vars.aws_region

default_tags {
    tags = {
        ManagedBy = "Terraform" 
    }
}
}