terraform {
  cloud {
    organization = "wf-demo-org"
    workspaces {
      name = "wf-demo-workspace"
    }
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.0"
    }
  }
}




provider "google" {
  project     = "my-project-id"
  region      = "us-central1"
  zone        = "us-central1-c"
  credentials = var.gcp-creds
}

variable "gcp-creds" {
default= ""
}

variable "region" {
  default = "us-central1"
  type    = string
}

variable "environment" {
  default     = "dev"
  description = "The environment name"
}



resource "google_storage_bucket" "terragoat_website" {
  name          = "terragot-${var.environment}"
  force_destroy = true
  labels = {
    git_commit           = "ff3ee8387837a499665630ebb0371be39ce35fb6"
    git_file             = "terraform/gcp/gcs.tf"
    git_last_modified_at = "2020-07-08 12:02:14"
    git_last_modified_by = "nimrodkor@gmail.com"
    git_modifiers        = "nimrodkor"
    git_org              = "bridgecrewio"
    git_repo             = "terragoat"
    yor_trace            = "bd00cd2e-f53f-4daf-8d4d-74c47846c1cc"
  }
}

resource "google_storage_bucket_iam_binding" "allow_public_read" {
  bucket  = google_storage_bucket.terragoat_website.id
  members = ["allUsers"]
  role    = "roles/storage.objectViewer"
}
