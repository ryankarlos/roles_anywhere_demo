

resource "aws_iam_role" "roles_anywhere_role" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
          "sts:TagSession",
          "sts:SetSourceIdentity"
        ]
        Effect = "Allow"
        Principal = {
          Service = "rolesanywhere.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_access" {
  role       = aws_iam_role.roles_anywhere_role.name
  policy_arn = var.s3_policy_arn
}


resource "aws_iam_role_policy_attachment" "s3_lambda_access" {
 role       = aws_iam_role.roles_anywhere_role.name
 policy_arn = "arn:aws:iam::aws:policy/AWSLambda_FullAccess"
}




resource "aws_rolesanywhere_trust_anchor" "trust_anchor" {

  name    = var.trust_anchor_name
  enabled = true

  source {
    source_data {
      acm_pca_arn = var.acm_pca_arn

    }
    source_type = "AWS_ACM_PCA"
  }
}

# Create a profile
resource "aws_rolesanywhere_profile" "demo_profile" {
  name      = var.profile_name
  role_arns = [aws_iam_role.roles_anywhere_role.arn]
  enabled   = true
}


resource "aws_acm_certificate" "this" {
  domain_name       = var.cert_domain
  certificate_authority_arn =  var.acm_pca_arn

}
