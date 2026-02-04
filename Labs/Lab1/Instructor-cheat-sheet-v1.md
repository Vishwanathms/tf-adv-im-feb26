1) ✅ Instructor Troubleshooting Cheat Sheet (IAM Role / IMDS Edition)
A. Quick identity verification (first command in failures)

Add this to your “triage checklist”:

aws sts get-caller-identity

If this fails:

Symptoms

Unable to locate credentials

Could not connect to the endpoint URL: http://169.254.169.254/...

Root causes

Jenkins agent is NOT running on the IAM-role VM

Instance profile missing

IMDS blocked by firewall/iptables, or IMDS disabled

Containerized agent without access to IMDS (common!)

Fix

Confirm Jenkins build is running on the intended agent node

Verify EC2 instance has an instance profile attached

If using Docker agent: ensure container can reach IMDS or use ECS task role instead

Ensure IMDSv2 is supported; AWS CLI v2 recommended

B. Backend failures (S3/DynamoDB)
Error configuring S3 Backend / AccessDenied

Fix

Validate the role has:

s3:ListBucket, s3:GetObject, s3:PutObject

dynamodb:GetItem, PutItem, DeleteItem, UpdateItem, DescribeTable

Check bucket policy isn’t denying the role

If bucket uses KMS encryption: add kms:Encrypt/Decrypt

C. State lock conflicts (same as before)
Error acquiring the state lock

Fix

Ensure no other pipeline run is active for same workspace

terraform force-unlock <LOCK_ID>

D. Workspace mistakes (new key learning)
Wrong workspace selected → wrong resources impacted

Fix

terraform workspace show
terraform workspace select dev


Instructor emphasis:

Always log workspace name before plan/apply

E. Common “gotchas” with IAM role + Jenkins
Jenkins running inside Docker container (agent)

If terraform runs inside a container:

IMDS may be blocked or not reachable

Fix: run agent on host, or allow IMDS access, or switch to ECS task role