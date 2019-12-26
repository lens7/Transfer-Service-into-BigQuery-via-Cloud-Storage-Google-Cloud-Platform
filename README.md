# Transfer-Service-into-BigQuery-via-Cloud-Storage-"Google Cloud Platform and Terraform"
Here we have automated the entire process of Creation of Google Cloud Storage buckets to store that that we are transferring via various transfer services, as of now Transfer from other Google cloud Storage buckets and public http/https links are supported, finally all this data is being processed into BigQuery for observations and Analysis.

All this automation involves the concept for "Terraform" and GCP insights

In General case for Transfer service to work GCP

Step 1 :  Create a Google Cloud Storage to store the migration files

Step 2 :  Store all your files in Cloud Storage

Step 3 :  Use the files in Cloud Storage to create BigQwery Dataset and Table and start Migrating

In this Terrraform script we handle all the code as well as the Infrastructure Development for the project
