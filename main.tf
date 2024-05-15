provider "kubernetes" {
  config_path    = "~/.kube/config"  # Ruta al archivo de configuración de Kubernetes
  config_context = "minikube"        # Nombre del contexto de Minikube
}

resource "kubernetes_deployment" "landing-page" {
  metadata {
    name = "landing-page"
    labels = {
      app = "landing-page"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "landing-page"
      }
    }

    template {
      metadata {
        labels = {
          app = "landing-page"
        }
      }

      spec {
        container {
          name  = "landing-page"
          image = "martinbech/my-landing-page:latest"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "landing-page-service" {
  metadata {
    name = "landing-page-service"
  }

  spec {
    selector = {
      app = "landing-page"
    }

    port {
      port        = 80
      target_port = 80
    }
  }
}

resource "kubernetes_deployment" "mysql-db" {
  metadata {
    name = "mysql-db"
    labels = {
      app = "mysql-db"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "mysql-db"
      }
    }

    template {
      metadata {
        labels = {
          app = "mysql-db"
        }
      }

      spec {
        container {
          name  = "mysql-db"
          image = "martinbech/my-mysql-image:latest"
          port {
            container_port = 3306
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "mysql-db-service" {
  metadata {
    name = "mysql-db-service"
  }

  spec {
    selector = {
      app = "mysql-db"
    }

    port {
      port        = 3306
      target_port = 3306
    }
  }
}

resource "kubernetes_deployment" "hello-world-app" {
  metadata {
    name = "hello-world-app"
    labels = {
      app = "hello-world-app"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "hello-world-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "hello-world-app"
        }
      }

      spec {
        container {
          name  = "hello-world-app"
          image = "martinbech/hello-world-app:latest"
          port {
            container_port = 8080
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "hello-world-app-service" {
  metadata {
    name = "hello-world-app-service"
  }

  spec {
    selector = {
      app = "hello-world-app"
    }

    port {
      port        = 8080
      target_port = 8080
    }
  }
}
