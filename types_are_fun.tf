variable "list_variable" {
  type    = list(string)
  default = []
}

output "empty_is_empty_right_question_mark" {
  value = var.list_variable == []
}

output "lists_are_fun" {
  value = type(var.list_variable)
}

output "tuples_are_fun" {
  value = type([])
}

output "booleans_are_fun" {
  value = tolist([]) == tuple([])
}

output "casting_will_work" {
  value = tolist([]) == var.list_variable
}

output "or_just_use_length" {
  value = len(var.list_variable) == 0
}
