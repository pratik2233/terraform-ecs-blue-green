# terraform-ecs-blue-green
AWS ECS Blue-Green Deployment using Terraform and ALB
📘 Page 1 — Architecture Diagram (Blue‑Green)
Clear logical flow:
Client
   |
   v
Application Load Balancer (HTTP)
   |---- 0%  ---> Blue Target Group  ---> ECS Service BLUE
   |
   |---- 100% ---> Green Target Group ---> ECS Service GREEN

✅ ECS Fargate
✅ Private subnets
✅ Zero downtime
✅ Traffic switch at ALB only
This is enterprise‑grade architecture, explained visually.

📘 Page 2 — GitHub Actions CI (Terraform)
Explains:

Workflow file location:
.github/workflows/terraform-ci.yml


Triggers:

Push to main
Pull request


Steps:

Checkout code
Setup Terraform
terraform fmt -check
terraform init
terraform plan



✅ Safe CI (no apply)
✅ Enterprise‑friendly
✅ Interview‑ready

📘 Page 3 — Sample GitHub Actions YAML
Ready‑to‑use CI config:
YAMLname: Terraform CIon:  push:    branches: [ main ]  pull_request:jobs:  terraform:    runs-on: ubuntu-latest    steps:      - uses: actions/checkout@v4      - uses: hashicorp/setup-terraform@v3      - run: terraform fmt -check      - run: terraform init      - run: terraform planShow more lines
✅ Clean
✅ Minimal
✅ Correct

✅ How to add this PDF to your GitHub repo
Shellcd ~/Terraform/aws-terrafrommkdir docsmv Terraform_ECS_Blue_Green_Architecture_and_CI.pdf docs/git add docs/git commit -m "Add architecture diagram and GitHub Actions CI documentation"git pushShow more lines

✅ Add this line to your README (recommended)
Markdown📄 **Architecture & CI Documentation**  See `docs/Terraform_ECS_Blue_Green_Architecture_and_CI.pdf`
