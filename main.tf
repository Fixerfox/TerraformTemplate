# 1. Configuración de los Providers
terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

provider "github" {
  # El token lo sacará automáticamente de la variable de entorno GITHUB_TOKEN 
  # que configuramos en el archivo .yml (secrets.MY_GITHUB_TOKEN)
}

# 2. Definición del Repositorio Principal
# Cambia "n8n-automator" si quieres que gestione otro nombre
resource "github_repository" "repo_principal" {
  name        = "n8n-automator"
  description = "Repositorio gestionado por Terraform para automatizaciones con n8n"
  visibility  = "public"
  
  # Importante: debe estar en true para poder crear ramas después
  auto_init   = true 
}

# 3. Creación de la rama DEVELOP
resource "github_branch" "develop" {
  repository    = github_repository.repo_principal.name
  branch        = "develop"
  source_branch = "main" # Indica que nace de la rama principal
}

# 4. Creación de la rama TESTING
resource "github_branch" "testing" {
  repository    = github_repository.repo_principal.name
  branch        = "testing"
  source_branch = "main" # Indica que nace de la rama principal
}

# 5. Opcional: Crear un archivo inicial dentro del repo
resource "github_repository_file" "readme_custom" {
  repository          = github_repository.repo_principal.name
  branch              = "main"
  file                = "TERRAFORM_INFO.md"
  content             = "# Info\nEste repositorio y sus ramas (develop/testing) son gestionados por Terraform."
  commit_message      = "Añadiendo archivo de info desde Terraform"
  overwrite_on_create = true
}
