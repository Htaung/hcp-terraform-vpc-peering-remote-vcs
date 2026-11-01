# HCP Terraform Intra Region VPC Peering with VCS Driven Using PR and folder wildcard patterns

Date: November 1, 2026 2:21 PM
Git Repo: https://github.com/Htaung/hcp-terraform-vpc-peering-remote-vcs
Hands on: Done
References: https://link.excalidraw.com/readonly/yfziGTVaJOPPLQ3VIHtM
URL: https://www.youtube.com/watch?v=s8stYI4emJo

- [Create VCS provider under terraform cloud](https://app.notion.com/p/HCP-Terraform-Intra-Region-VPC-Peering-with-VCS-Driven-Using-Main-Branch-and-folder-wildcard-pattern-40448d70c8c38002936be65a7ee96446?pvs=21)
- Create RestrictMain branch rule on github
- Create empty git repo

![Screenshot From 2026-11-01 14-21-43.png](HCP%20Terraform%20Intra%20Region%20VPC%20Peering%20with%20VCS%20Dr/Screenshot_From_2026-11-01_14-21-43.png)

- After added branch rule test on push to main branch

![image.png](HCP%20Terraform%20Intra%20Region%20VPC%20Peering%20with%20VCS%20Dr/image.png)

- Create fe-network-ws

![image.png](HCP%20Terraform%20Intra%20Region%20VPC%20Peering%20with%20VCS%20Dr/image%201.png)

- Create pull request

![image.png](HCP%20Terraform%20Intra%20Region%20VPC%20Peering%20with%20VCS%20Dr/image%202.png)

- Merge the pull request

![image.png](HCP%20Terraform%20Intra%20Region%20VPC%20Peering%20with%20VCS%20Dr/image%203.png)

- Create fe-security-ws workspace under HCP terraform cloud
- Push code to fe-security branch

```jsx
git checkout -b fe-security
git add .
git commit -m "Add fe-security"
git push --set-upstream origin fe-security
```

- Create PR in fe-security to main
- Plan finished successfully

![image.png](HCP%20Terraform%20Intra%20Region%20VPC%20Peering%20with%20VCS%20Dr/image%204.png)

- Approved PR, merge PR

![image.png](HCP%20Terraform%20Intra%20Region%20VPC%20Peering%20with%20VCS%20Dr/image%205.png)

- Create fe-compute-ws in terraform cloud and create PR for fe-compute branch

![image.png](HCP%20Terraform%20Intra%20Region%20VPC%20Peering%20with%20VCS%20Dr/image%206.png)

- Create be-network-ws in terraform cloud and create PR for be-network-ws branch, merge

![image.png](HCP%20Terraform%20Intra%20Region%20VPC%20Peering%20with%20VCS%20Dr/image%207.png)

- Create be-security-ws in terraform cloud create empty run

![image.png](HCP%20Terraform%20Intra%20Region%20VPC%20Peering%20with%20VCS%20Dr/image%208.png)

![image.png](HCP%20Terraform%20Intra%20Region%20VPC%20Peering%20with%20VCS%20Dr/image%209.png)

- Create PR from be-security branch to main

![image.png](HCP%20Terraform%20Intra%20Region%20VPC%20Peering%20with%20VCS%20Dr/image%2010.png)

- Merge PR to main branch

![image.png](HCP%20Terraform%20Intra%20Region%20VPC%20Peering%20with%20VCS%20Dr/image%2011.png)

- Create be-compute-ws in terraform cloud and create EMPTY RUN

![image.png](HCP%20Terraform%20Intra%20Region%20VPC%20Peering%20with%20VCS%20Dr/image%2012.png)

- Create PR from be-compute to main branch

![image.png](HCP%20Terraform%20Intra%20Region%20VPC%20Peering%20with%20VCS%20Dr/image%2013.png)

- Getting errors show on git and terraform cloud

![image.png](HCP%20Terraform%20Intra%20Region%20VPC%20Peering%20with%20VCS%20Dr/image%2014.png)

![image.png](HCP%20Terraform%20Intra%20Region%20VPC%20Peering%20with%20VCS%20Dr/image%2015.png)

- Fix error and push to be-compute, terraform process PR automatically even i didn’t create PR yet

![image.png](HCP%20Terraform%20Intra%20Region%20VPC%20Peering%20with%20VCS%20Dr/image%2016.png)

![image.png](HCP%20Terraform%20Intra%20Region%20VPC%20Peering%20with%20VCS%20Dr/image%2017.png)

```jsx
Those two runs are speculative plans, and TFC starts them on its own when a pull request is open on that branch.
What happened
The PR is open on be-compute, even if you think of it as “created once”. TFC’s GitHub integration watches that PR.Your first PR created run b0f4e6b. It was plan-only and errored.When you pushed the fix to the same branch, GitHub updated the same PR, and TFC ran a new plan for commit 225830b. That one shows “Planned and finished”, so your fix worked.You don’t need a second PR. Every push to an open PR’s branch triggers a fresh speculative plan.
```

- Retrieving key via secret manager take the secret id from output

![image.png](HCP%20Terraform%20Intra%20Region%20VPC%20Peering%20with%20VCS%20Dr/image%2018.png)

```jsx

aws secretsmanager get-secret-value \
--secret-id hc-frontend-ssh-key.pem-private \
--query SecretString \
--output text \
--region ap-southeast-1 > fe-ssh-key.pem

aws secretsmanager get-secret-value \
--secret-id hc-backend-ssh-key.pem-private \
--query SecretString \
--output text \
--region ap-southeast-1 > be-ssh-key.pem

```

![image.png](HCP%20Terraform%20Intra%20Region%20VPC%20Peering%20with%20VCS%20Dr/image%2019.png)

```jsx
sudo aws secretsmanager get-secret-value --secret-id hc-backend-ssh-key.pem-private --query SecretString --output text --region ap-southeast-1 > be-ssh-key.pem

aws: [ERROR]: An error occurred (AccessDeniedException) when calling the GetSecretValue operation: User: arn:aws:iam::538632037077:user/master-programmatic-admin is not authorized to perform: secretsmanager:GetSecretValue on resource: hc-backend-ssh-key.pem-private because no identity-based policy allows the secretsmanager:GetSecretValue action

sudo aws secretsmanager get-secret-value --secret-id hc-backend-ssh-key.pem-private --query SecretString --output text --region ap-southeast-1 --profile master-console-admin > be-ssh-key.pem
```

![image.png](HCP%20Terraform%20Intra%20Region%20VPC%20Peering%20with%20VCS%20Dr/image%2020.png)

- Instance created

![image.png](HCP%20Terraform%20Intra%20Region%20VPC%20Peering%20with%20VCS%20Dr/image%2021.png)

- **hc-frontend-vpc** resource map

![image.png](HCP%20Terraform%20Intra%20Region%20VPC%20Peering%20with%20VCS%20Dr/image%2022.png)

- hc-backend-vpc resource map

![image.png](HCP%20Terraform%20Intra%20Region%20VPC%20Peering%20with%20VCS%20Dr/image%2023.png)

![image.png](HCP%20Terraform%20Intra%20Region%20VPC%20Peering%20with%20VCS%20Dr/image%2024.png)