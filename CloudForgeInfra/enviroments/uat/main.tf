module "rg" {
  source = "../../module/rg"
  karag1 = var.karag1
}
module "vnet" {
  depends_on = [module.rg]
  source     = "../../module/vnet"
  kavnet1    = var.kavnet1
}
module "subnet" {
  depends_on = [module.vnet]
  source     = "../../module/subnet"
  kasubnet1  = var.kasubnet1
}

module "niclvm" {
  depends_on = [module.subnet]
  source     = "../../module/nic-lvm"
  niclvm     = var.niclvm
}
module "nat" {
  depends_on = [ module.rg ]
  source = "../../module/nat"
}

