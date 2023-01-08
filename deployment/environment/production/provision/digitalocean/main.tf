# Terraform DO Provider Docs: https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs

# Change the domain name to your app's in the Domain section below

#------ Data ------#
# Use the name of your Personal Access Token
data "digitalocean_ssh_key" "terraform-digitalocean-key" {
  name = "terraform-digitalocean-key"
}

data "digitalocean_kubernetes_versions" "k8s-version" {
  version_prefix = "1.25."
}

#------ Provider ------#
terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

variable "do_token" {}
variable "pvt_key" {}

provider "digitalocean" {
  token = var.do_token
}

#------ Database ------#
resource "digitalocean_database_db" "appcket-database" {
  cluster_id = digitalocean_database_cluster.appcket-database-cluster.id
  name       = "appcket"
}

resource "digitalocean_database_cluster" "appcket-database-cluster" {
  name       = "appcket-database-cluster"
  engine     = "pg"
  version    = "14"
  size       = "db-s-1vcpu-1gb"
  region     = "nyc1"
  node_count = 1
}

resource "digitalocean_database_user" "database_user" {
  cluster_id = digitalocean_database_cluster.appcket-database-cluster.id
  name       = "dbuser"
}

#------ Container Registry ------#
resource "digitalocean_container_registry" "appcket-container-registry" {
  name                   = "appcket-container-registry"
  subscription_tier_slug = "basic"
  region                 = "nyc3"
}

#------ Kubernetes Cluster ------#
resource "digitalocean_kubernetes_cluster" "appcket-k8s-cluster" {
  name         = "appcket-k8s-cluster"
  region       = "nyc1"
  auto_upgrade = true
  version      = data.digitalocean_kubernetes_versions.k8s-version.latest_version

  maintenance_policy {
    start_time  = "04:00"
    day         = "sunday"
  }

  node_pool {
    name       = "default"
    size       = "s-2vcpu-4gb"
    node_count = 2
  }
}

#------ Domain ------#
resource "digitalocean_domain" "appcket-domain" {
  name       = "appcket.com"
}

#------ Project ------#
resource "digitalocean_project" "production-appcket" {
  name        = "production-appcket"
  description = "Production resources for appcket"
  purpose     = "Web Application"
  environment = "Production"
  resources = [
    digitalocean_database_cluster.appcket-database-cluster.urn,
    digitalocean_kubernetes_cluster.appcket-k8s-cluster.urn,
    digitalocean_domain.appcket-domain.urn
  ]
}