karag1 = {
  rg01 = {
    resource_group_name = "karg001"
    location            = "Japan East"
} }

kavnet1 = {

  vnet01 = {
    virtual_network_name = "kavnet"
    resource_group_name  = "karg001"
    location             = "Japan East"
    address_space        = ["10.0.0.0/16"]

  }
}
kasubnet1 = {
  subnet01 = {
    subnet_name          = "kasubnet"
    resource_group_name  = "karg001"
    virtual_network_name = "kavnet"
    address_prefixes       = ["10.0.2.0/24"]

  }
}

niclvm = {
  nicvm = {
    resource_group_name = "karg001"
    location            = "Japan East"
    nic_name            = "nicka"
    lvmname             = "lvmka"
    # username      = "administrator"
    admin_password      = "Roor123456"


  }
}


