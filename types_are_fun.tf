variable "list_variable" {
  type    = list(string)
  default = []
}

# This is false
output "empty_is_empty_right_question_mark" {
  value = var.list_variable == []
}

# This is false - more explicit demonstration of above
output "booleans_are_fun" {
  value = tolist([]) == []
}

# STILL FALSE - list(dynamic) vs. list(string)
output "casting_wont_save_you" {
  value = tolist([]) == var.list_variable
}

# This is the way
output "just_use_length" {
  value = length(var.list_variable) == 0
}
