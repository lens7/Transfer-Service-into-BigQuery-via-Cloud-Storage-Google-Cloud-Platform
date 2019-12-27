# Transfer-Service-into-BigQuery-via-Cloud-Storage-"Google Cloud Platform and Terraform"
Here we have automated the entire process of Creation of Google Cloud Storage buckets to store that that we are transferring via various transfer services, as of now Transfer from other Google cloud Storage buckets and public http/https links are supported, finally all this data is being processed into BigQuery for observations and Analysis.

All this automation involves the concept for "Terraform" and GCP insights

In General case for Transfer service to work GCP

Step 1 :  Create a Google Cloud Storage to store the migration files

Step 2 :  Store all your files in Cloud Storage

Step 3 :  Use the files in Cloud Storage to create BigQuery Dataset and Table and start Migrating

In this Terrraform script we handle all the code as well as the Infrastructure Development for the project.

we can have multiple non-related Components configured by Terraform, which can be found easily at the Terraform Docs. In this case we create BigQuery Dataset/Tables and Cloud Storage by Terraform itself, We then configure IAM roles in the cloud storage(optional). Here we are trying to extract the data from various other sources into a single Cloud Storage Bucket, so we don't have to necessarily add these roles, we can even send data from the accounts registered at the the bucket.

The necessary permissions from cloud storage(source) to cloud storage(destination) needed at the source side where we need to provide are Bucket and Object Reader permissions at indvidual bucket level.

Further to get data from http/https we will be using the concept of 'null_resource' and <local-exec> where we combine the Terraform and Gcloud commands, the CURL commands lets us have the data imported at the shell level and then we use the gsutil it combines these files into the respective Cloud Storage Bucket..
  
Lastly we can have these all CSV databases into BigQuery viaa the BQ commands, we even dont need to know thw schema for the databases, the autodetect features helps us in the cause. We combine these commands to get data imported into BigQuery in similar sense as gcloud commands were used earlier.

rest functionalities that can be added are getting data from other Cloud Storages and getting large size databases in lesser time.
these will be work in progress for now.
