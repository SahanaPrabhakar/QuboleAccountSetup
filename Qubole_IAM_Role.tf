resource "aws_iam_policy" "policyec2" {
  name        = "Qu_EC2_Policy"
  path        = "/"
  description = "EC2 policy for Qubole"

  policy = <<EOF
{
    
    "Version": "2012-10-17",

    "Statement": [
        
        {
            
            "Effect": "Allow",

            "Action": [

                "ec2:AuthorizeSecurityGroupEgress",

                "ec2:AuthorizeSecurityGroupIngress",

                "ec2:AttachVolume",

                "ec2:CancelSpotInstanceRequests",

                "ec2:CreateSecurityGroup",

                "ec2:CreateTags",

                "ec2:CreateVolume",

                "ec2:DeleteSecurityGroup",

                "ec2:DeleteTags",

                "ec2:DeleteVolume",

                "ec2:Describe*",

                "ec2:DescribeVolumes",

                "ec2:DetachVolume",

                "ec2:ImportKeyPair",

                "ec2:DescribeKeyPairs",

                "ec2:ModifyInstanceAttribute",

                "ec2:RequestSpotInstances",

                "ec2:RevokeSecurityGroupIngress",

                "ec2:RunInstances",

                "ec2:StartInstances",

                "ec2:StopInstances",

                "ec2:TerminateInstances"

            ],

            "Resource": [

                "*"

            ]

        },

        {

            "Effect": "Allow",

            "Action": [

                "sts:DecodeAuthorizationMessage"

            ],
            "Resource": [

                "*"

            ]

        }

    ]

}
EOF
}

resource "aws_iam_policy" "policys3" {
  name        = "Qu_S3_Policy"
  path        = "/"
  description = "S3 policy for Qubole"

  policy = <<EOF
{
    "Version": "2012-10-17",

    "Statement": [

        {

            "Effect": "Allow",

            "Action": [

                "s3:DeleteObject",

                "s3:GetObject",

                "s3:GetObjectAcl",

                "s3:PutObject",

                "s3:PutObjectAcl",

                "s3:GetBucketAcl",

                "s3:GetBucketLocation",

                "s3:ListBucket"

            ],

            "Resource": [

                "arn:aws:s3:::sparkstoragedemo/*"

,"arn:aws:s3:::sparkstoragedemo"
       
            ]

        },

        {

            "Effect": "Allow",

            "Action": [

                "s3:GetObject",

                "s3:ListBucket"

            ],

            "Resource": [

                "*"

            ]

        },

        {

            "Effect": "Allow",

            "Action": [

                "s3:ListAllMyBuckets"

            ],

            "Resource": [

                "*"

            ]

        }

    ]
}
EOF
}
    

resource "aws_iam_role" "QU_Iam_Role" {
  name = "QU_Iam_Role"
  assume_role_policy = <<EOF
{
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Principal": {
            "Service": "ec2.amazonaws.com"
          },
          "Effect": "Allow",
          "Sid": ""
        },
	{
	  "Action":"sts:AssumeRole",
	  "Effect":"Allow",
	  "Condition": {
	    "StringEquals":{"sts:ExternalId": "HA3DSODJMNSWEYLI"}
	   },
	   "Principal": {
	    "AWS": "arn:aws:iam::805246085872:root"
	   }
	}
      ]
}
EOF
}


resource "aws_iam_role_policy_attachment" "role-attach-ec2" {
    role       = "${aws_iam_role.QU_Iam_Role.name}"
    policy_arn = "${aws_iam_policy.policyec2.arn}"
}

resource "aws_iam_role_policy_attachment" "role-attach-s3" {
    role       = "${aws_iam_role.QU_Iam_Role.name}"
    policy_arn = "${aws_iam_policy.policys3.arn}"
}