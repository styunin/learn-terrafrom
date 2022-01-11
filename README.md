# learn-terraform on GCP platform
My personal notes to learn terraform with the GCP.

Still in progress.

For now the goal is to have 3 VMs with NGNIX static page and load balancer.
On top of that each VM should have corresponding GS bucket.

1. Generate private key for an existing service account of the project or create new SA and generate the key 
2. Get the key from previous step and store it in the folder for terrafrom
3. Populate provider.tf, main.tf, etc files and update project-id, resource names, etc.

