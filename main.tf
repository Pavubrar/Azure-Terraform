

module "resource_group" {
  source = "./modules/resource_group"

  name     = var.resource_group_name
  location = var.location

  tags = {
    environment = var.environment
    owner       = var.owner
  }
}
