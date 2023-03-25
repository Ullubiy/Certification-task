data "yandex_compute_image" "ubuntu-18-04" {
  family = "ubuntu-1804-lts"
}
 
resource "yandex_compute_instance" "vm-build" {
  name = "build"
 
  resources {
    cores  = 2
    memory = 2
  }
 
  boot_disk {
    initialize_params {
      image_id = "fd82d9mref0p62tbo6mk"
    }
  }
 
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_terraform.id
    nat       = true
  }
    metadata = {
    user-data = "${file("./meta.yml")}"
  }
}
 
 resource "yandex_compute_instance" "vm-deploy" {
  name = "deploy"
 
  resources {
    cores  = 2
    memory = 2
  }
 
  boot_disk {
    initialize_params {
      image_id = "fd82d9mref0p62tbo6mk"
    }
  }
 
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_terraform.id
    nat       = true
  }
    metadata = {
    user-data = "${file("./meta.yml")}"
  }
}
 
resource "yandex_vpc_subnet" "subnet_terraform" {
  name           = "sub_terraform"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network_terraform.id
  v4_cidr_blocks = ["10.128.0.0/24"]
}
resource "local_file" "address" {
  content  = "{ \"build_ip\" : \"${yandex_compute_instance.build.network_interface.0.ip_address}\", \"deploy_ip\" : \"${yandex_compute_instance.deploy.network_interface.0.ip_address}\" }"
  filename = "../address.json"
}
