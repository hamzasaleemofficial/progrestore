removed {
  from = module.terraform_state

  lifecycle {
    destroy = false
  }
}