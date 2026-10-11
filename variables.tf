variable "storage_bucket_objects" {
  description = <<EOT
Map of storage_bucket_objects, attributes below
Required:
    - bucket
    - name
Optional:
    - cache_control
    - content
    - content_disposition
    - content_encoding
    - content_language
    - content_type
    - deletion_policy
    - detect_md5hash
    - event_based_hold
    - force_empty_content_type
    - kms_key_name
    - metadata
    - source
    - source_md5hash
    - storage_class
    - temporary_hold
    - contexts (block):
        - custom (required, block):
            - key (required)
            - value (required)
    - customer_encryption (block):
        - encryption_algorithm (optional)
        - encryption_key (required)
    - retention (block):
        - mode (required)
        - retain_until_time (required)
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
EOT

  type = map(object({
    bucket                   = string
    name                     = string
    cache_control            = optional(string)
    content                  = optional(string)
    content_disposition      = optional(string)
    content_encoding         = optional(string)
    content_language         = optional(string)
    content_type             = optional(string)
    deletion_policy          = optional(string)
    detect_md5hash           = optional(string)
    event_based_hold         = optional(bool)
    force_empty_content_type = optional(bool)
    kms_key_name             = optional(string)
    metadata                 = optional(map(string))
    source                   = optional(string)
    source_md5hash           = optional(string)
    storage_class            = optional(string)
    temporary_hold           = optional(bool)
    contexts = optional(object({
      custom = list(object({
        key   = string
        value = string
      }))
    }))
    customer_encryption = optional(object({
      encryption_algorithm = optional(string)
      encryption_key       = string
    }))
    retention = optional(object({
      mode              = string
      retain_until_time = string
    }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.storage_bucket_objects : (
        v.contexts == null || (length(v.contexts.custom) >= 1)
      )
    ])
    error_message = "Each custom list must contain at least 1 items"
  }
}

