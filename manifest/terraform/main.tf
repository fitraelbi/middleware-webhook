

provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_cloud_run_service" "middleware-webhook" {
  name     = var.service_name
  location = var.region

  template {
    spec {
      containers {
        image = var.image

        dynamic "env" {
          for_each = var.env_variables
          content {
            name  = env.key
            value = env.value
          }
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}


