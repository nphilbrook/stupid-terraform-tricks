output "environment_data_all" {
  value       = data.environment_variables.all
  description = "All environment variables, derived from Epp0/environment provider"
}

output "still_ws_id" {
  value = data.tfe_workspace.this.id
}
