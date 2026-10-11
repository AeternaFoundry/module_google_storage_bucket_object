resource "google_storage_bucket_object" "storage_bucket_objects" {
  for_each = var.storage_bucket_objects

  bucket                   = each.value.bucket
  name                     = each.value.name
  cache_control            = each.value.cache_control
  content                  = each.value.content
  content_disposition      = each.value.content_disposition
  content_encoding         = each.value.content_encoding
  content_language         = each.value.content_language
  content_type             = each.value.content_type
  deletion_policy          = each.value.deletion_policy
  detect_md5hash           = each.value.detect_md5hash
  event_based_hold         = each.value.event_based_hold
  force_empty_content_type = each.value.force_empty_content_type
  kms_key_name             = each.value.kms_key_name
  metadata                 = each.value.metadata
  source                   = each.value.source
  source_md5hash           = each.value.source_md5hash
  storage_class            = each.value.storage_class
  temporary_hold           = each.value.temporary_hold

  dynamic "contexts" {
    for_each = each.value.contexts != null ? [each.value.contexts] : []
    content {
      dynamic "custom" {
        for_each = contexts.value.custom
        content {
          key   = custom.value.key
          value = custom.value.value
        }
      }
    }
  }

  dynamic "customer_encryption" {
    for_each = each.value.customer_encryption != null ? [each.value.customer_encryption] : []
    content {
      encryption_algorithm = customer_encryption.value.encryption_algorithm
      encryption_key       = customer_encryption.value.encryption_key
    }
  }

  dynamic "retention" {
    for_each = each.value.retention != null ? [each.value.retention] : []
    content {
      mode              = retention.value.mode
      retain_until_time = retention.value.retain_until_time
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}

