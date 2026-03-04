terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

provider "github" {
  # No pongas el token aquí; lo pasaremos por una variable secreta
}

# Definimos el nuevo repositorio
resource "github_repository" "nuevo_repo" {
  name        = "nombre-del-repo-final" 
  description = "Repositorio gestionado por Terraform"
  visibility  = "public"
  auto_init   = true
}

# Rama develop
resource "github_branch" "develop" {
  repository    = github_repository.nuevo_repo.name
  branch        = "develop"
  source_branch = "main"
}

# Rama testing
resource "github_branch" "testing" {
  repository    = github_repository.nuevo_repo.name
  branch        = "testing"
  source_branch = "main"
}
