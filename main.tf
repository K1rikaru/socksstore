terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.74.0"
    }
  }
}
provider "yandex" {
  token     = "y0_AgAAAABjQDGCAATuwQAAAAD6p4erAAAuWPZwwcRCzqlJHU2l81KLb83thQ"
  cloud_id  = "b1g3bbrua7s7c0f0jmm4"
  folder_id = "b1gdsemn0vc3vkk6k807"
  zone      = "ru-central1-a"
}

resource "yandex_vpc_network" "network" {
  name = "swarm-network"
}

resource "yandex_vpc_subnet" "subnet" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

module "swarm_cluster" {
  source        = "./modules/instance"
  vpc_subnet_id = yandex_vpc_subnet.subnet.id
  managers      = 1
  workers       = 2
}
