# output

output "name" {
  value = module.elasticsearch.name
}

output "endpoint" {
  value = module.elasticsearch.endpoint
}

output "domain" {
  value = module.elasticsearch.domain
}

output "snapshot_bucket" {
  value = module.elasticsearch.snapshot_bucket
}

output "snapshot_role_arn" {
  value = module.elasticsearch.snapshot_role_arn
}
