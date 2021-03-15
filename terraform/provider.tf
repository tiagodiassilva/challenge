provider "aws" {
  region                  = "sa-east-1"
  shared_credentials_file = "/root/.aws/credentials"
  profile                 = "iam_user"
}
