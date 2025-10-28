variable "list_variable" {
  type    = list(string)
  default = []
}

output "empty_is_empty_right_question_mark" {
  value = var.list_variable == []
}

output "booleans_are_fun" {
  value = tolist([]) == []
}

output "casting_will_work" {
  value = tolist([]) == var.list_variable
}

output "or_just_use_length" {
  value = length(var.list_variable) == 0
}
