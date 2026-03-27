terraform {
  required_providers {
    render = {
      source  = "render-oss/render"
      version = ">= 0.1.0"
    }
  }
}

provider "render" {
  api_key = var.render_api_key
}

resource "render_web_service" "flask_app" {
  name   = "flask-render-iac"
  plan   = "free"
  region = "frankfurt"

  runtime = "docker"

  image = {
    url = var.image_url
  }

  auto_deploy = false

  env_vars = [
    {
      key   = "ENV"
      value = "production"
    }
  ]
}
