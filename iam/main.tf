resource "aws_iam_user" "user" {
  name = "Tera-user"
}

resource "aws_iam_account_password_policy" "name" {
  minimum_password_length        = 8
  require_lowercase_characters   = true
  require_numbers                = true
  require_uppercase_characters   = true
  require_symbols                = true
  allow_users_to_change_password = false
}

resource "aws_iam_user_login_profile" "name" {
  user = aws_iam_user.user.name
  #password = "Tera@2024"
  password_reset_required = false

}
output "password" {
  value = aws_iam_user_login_profile.name
}

#resource "aws_iam_policy" "policy" {
  #name = "ec2"
  #policy = "arn:aws:iam::aws:policy/AdministratorAccess"
#}

resource "aws_iam_policy_attachment" "Attch" {
  name = "ec2-policy"
  users = ["aws_iam_user.user.name"]
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  depends_on = [ aws_iam_user.userc ]
}