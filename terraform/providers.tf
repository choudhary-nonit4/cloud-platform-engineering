provider "aws" {
    region = vars.aws_region

default_tags {
    tags = {
        ManagedBy = "Terraform" 
    }
}
}

# ---------------------------------------------------------
# Kubernetes
# Typically points at an EKS cluster created elsewhere in
# this config (or a data source referencing an existing one).
# ---------------------------------------------------------
provider "kubernetes" {
  host                   = data.aws_eks_cluster.this.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)

  exec {
    api_version = "client.authentication.k8s.io/v1"
    command     = "aws"
    args = [
      "eks", "get-token",
      "--cluster-name", data.aws_eks_cluster.this.name,
      "--region", var.aws_region
    ]
  }
}

# ---------------------------------------------------------
# Helm
# Reuses the same cluster auth as the Kubernetes provider.
# ---------------------------------------------------------
provider "helm" {
  kubernetes = {
    host                   = data.aws_eks_cluster.this.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)

    exec = {
      api_version = "client.authentication.k8s.io/v1"
      command     = "aws"
      args = [
        "eks", "get-token",
        "--cluster-name", data.aws_eks_cluster.this.name,
        "--region", var.aws_region
      ]
    }
  }
}

# ---------------------------------------------------------
# TLS
# No configuration required — logical provider.
# ---------------------------------------------------------
provider "tls" {}

# ---------------------------------------------------------
# Random
# No configuration required — logical provider.
# ---------------------------------------------------------
provider "random" {}