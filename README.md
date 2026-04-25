# terraform-ecs-blue-green
AWS ECS Blue-Green Deployment using Terraform and ALB
✅ Page 1 — Project Overview

What problem is solved
Why Blue‑Green
Why Terraform
What AWS services are used


✅ Page 2 — Architecture Diagram (Explained)
Client
  |
  v
ALB (HTTP)
 |-- Blue Target Group
 |-- Green Target Group

ECS Fargate:
- Blue Service
- Green Service


Zero downtime
Traffic control at ALB
Enterprise‑safe design


✅ Page 3 — env/dev/main.tf
✅ Full file
✅ Explained module by module
✅ Correct wiring (VPC → SG → ALB → ECS)

✅ Page 4 — modules/alb/main.tf
✅ ALB
✅ Blue & Green Target Groups
✅ Weighted Listener (0/100, 100/0)
✅ Traffic switch logic

✅ Page 5 — modules/ecs/main.tf
✅ ECS Cluster
✅ Task Definition
✅ Blue ECS Service
✅ Green ECS Service
✅ Correct load_balancer {} placement

✅ Page 6 — GitHub Actions CI
✅ .github/workflows/terraform-ci.yml
✅ fmt, init, plan
✅ Safe CI (no apply)
✅ Interview‑ready pipeline

✅ Page 7 — GitHub Push Steps
✅ git init
✅ .gitignore
✅ git add
✅ git commit
✅ git pull --rebase
✅ git push
