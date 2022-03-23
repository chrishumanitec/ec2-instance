locals {
  cloud_config_config = <<-END
    #cloud-config
    ${jsonencode({

  write_files = [for filepath, filecontent in var.spec.containers.image.files :
    {

      path        = filepath
      permissions = filecontent.mode
      owner       = "root:root"
      encoding    = "b64"
      content     = base64encode(filecontent.value)
    }
  ]
})}
  END
}