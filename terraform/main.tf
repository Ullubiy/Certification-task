terraform {
  required_version = "= 1.4.2"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "= 0.73"
    }
  }
}

provider "yandex" {
  token     = "y0_AgAEA7qh4eXMAATuwQAAAADevgldFD7Z0RUtTlCnXNB6hAX8_Nv5WcQ"
  cloud_id  = "b1g4eogkmpot4vmo0qe6"
  folder_id = "b1gv45vvtk1g6k540pte"
  zone      = "ru-central1-a"
 }
