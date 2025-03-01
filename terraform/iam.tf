/* -----------------------------------------------------------------------------------
EKS Amazon EBS CSI add-on
----------------------------------------------------------------------------------- */
resource "aws_iam_role" "amazon_EBS_CSI_iam_role" {
  name        = "amazon-ebs-csi-irsa"
  description = "IAM role for Amazon EBS CSI driver add-on"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17"
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : module.eks.oidc_provider_arn
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringLike" : {
            "${module.eks.oidc_provider}:sub" : "system:serviceaccount:kube-system:ebs-csi-controller-sa",
            "${module.eks.oidc_provider}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })

  tags = local.default_tags
}

resource "aws_iam_role_policy_attachment" "amazon_EBS_CSI_iam_role" {
  role       = aws_iam_role.amazon_EBS_CSI_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

/* -----------------------------------------------------------------------------------
VPC CNI
----------------------------------------------------------------------------------- */
resource "aws_iam_role" "vpc_cni_iam_role" {
  name        = "vpc-cni-irsa"
  description = "IAM role for VPC-CNI add-on"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17"
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : module.eks.oidc_provider_arn
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringLike" : {
            "${module.eks.oidc_provider}:sub" : "system:serviceaccount:kube-system:aws-node",
            "${module.eks.oidc_provider}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })

  tags = local.default_tags
}

resource "aws_iam_role_policy_attachment" "vpc_cni_iam_role" {
  role       = aws_iam_role.vpc_cni_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}