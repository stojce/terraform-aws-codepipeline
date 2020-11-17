# CI/CD with Terraform and AWS CodePipeline

Why CI/CD? CI/CD plays important role in application lifecycle management. CI/CD pipelines are repeatable, less prone to errors, and they are self-explanatory - can serve as a documentation of deployment process.

AWS CodePipeline is an excellent choice for CI/CD if your infrastructure is on Amazon AWS.

Usually CI/CD pipelines consists of following stages:

- source - take latest changes from source control
- package management - install required packages
- unit test - run unit tests
- build
- deploy
- verify - run smoke tests

We will take a look to a very simple CI/CD pipeline - static web site hosted on S3 and we will use yarn package manager. Also, we will assume that source code is hosted on GitHub.

We at TyphoonX usually start Terraform IaC projects with provider setup and variables definition.

Terraform provider definition is defined in [main.tf](./main.tf)

Variables used trough the project: [variables.tf](./variables.tf)

Next, we need to create AWS CodePipeline script with following stages:

- Source - we will use GitHub source control
- Build - simple buildspec
- Deploy - copy artifacts to AWS S3 Bucket

First we need to create AWS CodeBuild project with [codebuild.tf](./codebuild.tf) having buildspec defined in [buildspec.yml](./buildspec.yml)

Next we will create [pipeline](./pipeline.tf) and use CodeBuild project that we've just created.

AWS CodePipeline scriptIn order to have to automate everything, we need to connect source control with the pipeline and trigger pipeline release on code changes / commits. Next, we will create hooks that will trigger pipeline release.

Web [hooks](./hooks.tf) for AWS and GitHub, using random secret key si required for triggering automated builds.

Finally we are defining [roles](roles.tf) with attached required policies, [s3 buckets](s3.tf) for build and deploy.

In more advanced setup additional stages and configurations can be added, like:

- packaging and security check,
- integration tests,
- smoke tests,
- notifications, approvals, Pull Requests.
