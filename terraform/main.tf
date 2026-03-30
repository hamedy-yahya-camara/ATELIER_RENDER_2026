terraform {
  required_providers {
    render = {
      source  = "render-oss/render"
      version = ">= 1.7.0"
    }
  }
}

provider "render" {
  api_key  = var.render_api_key
  owner_id = var.render_owner_id
}

variable "github_actor" {
  description = "GitHub username"
  type        = string
}

# PostgreSQL Managed Database
resource "render_postgres" "postgres" {
  name   = "postgres-${var.github_actor}"
  plan   = "free"
  region = "frankfurt"
}

# Flask Backend
resource "render_web_service" "flask_app" {
  name   = "flask-render-iac-${var.github_actor}"
  plan   = "free"
  region = "frankfurt"
  runtime_source = {
    image = {
      image_url = var.image_url
      tag       = var.image_tag
    }
  }
  env_vars = {
    ENV = {
      value = "production"
    }
    DATABASE_URL = {
      value = render_postgres.postgres.connection_string
    }
  }
}

# Adminer Web Service
resource "render_web_service" "adminer" {
  name   = "adminer-${var.github_actor}"
  plan   = "free"
  region = "frankfurt"
  runtime_source = {
    image = {
      image_url = "ghcr.io/shyim/adminerevo"
      tag       = "latest"
    }
  }
  env_vars = {}
}
