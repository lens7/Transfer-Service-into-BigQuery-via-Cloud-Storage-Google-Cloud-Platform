resource "google_bigquery_dataset" "default" {
  dataset_id                  = "firstBQTable"
  friendly_name               = "test"
  description                 = "This is a test description"
  location                    = "EU"
  default_table_expiration_ms = 3600000

  labels = {
    env = "default"
  }
}
# we are building infrastructure here for BigQuery Dataset and table, this steps takes 2-3 secs while automating the process

resource "google_bigquery_table" "default" {
  dataset_id = google_bigquery_dataset.default.dataset_id
  table_id   = "table1"

  labels = {
    env = "default"
  }

}
# we are building infrastructure here for Table in BQ Dataset, here we can also provide schema for the Databases we wish to enter in this table
# for general purpose and effectiveness we won't use schema as we can autodetect it while transferring data

resource "google_storage_bucket" "ingsid2" {
  name          = "ingsid2"
  location      = "${var.location}"
  storage_class = "MULTI_REGIONAL"
  force_destroy = true
}

# we are building infrastructure here for Cloud Storage Bucket, this steps takes 2-3 secs while automating the process

resource "google_storage_bucket_iam_member" "edit1" {
  bucket = "${google_storage_bucket.ingsid2.name}"
  role = "roles/storage.admin"
  member = "user:example@gmail.com"
  depends_on = [google_storage_bucket.ingsid2]
}
resource "google_storage_bucket_iam_member" "edit2" {
  bucket = "${google_storage_bucket.ingsid2.name}"
  role = "roles/storage.legacyBucketWriter"
  member = "user:example@gmail.com"
  depends_on = [google_storage_bucket_iam_member.edit1]
}
resource "google_storage_bucket_iam_member" "edit3" {
  bucket = "${google_storage_bucket.ingsid2.name}"
  role = "roles/storage.objectAdmin"
  member = "user:example@gmail.com"
  depends_on = [google_storage_bucket_iam_member.edit2]
}


resource "null_resource" "copy_data_from_other_cloudstorage" {
provisioner "local-exec" {
    command = "gsutil cp -r gs://terra-bucket123  gs://ingsid2; gsutil cp -r gs://20th-december gs://ingsid2 "
   }
  depends_on = [google_storage_bucket_iam_member.edit3]
}


resource "null_resource" "download_sample_cc_into_gcs" {
provisioner "local-exec" {
command = <<EOF
curl http://eforexcel.com/wp/wp-content/uploads/2017/07/1500000%20CC%20Records.zip > cc_records.zip
unzip cc_records.zip
rm cc_records.zip
mv 1500000\ CC\ Records.csv cc_records.csv
gsutil cp cc_records.csv gs://ingsid2
rm cc_records.csv
EOF
}
  depends_on = [null_resource.copy_data_from_other_cloudstorage]
}

resource "null_resource" "copy_data_into_big_query" {
provisioner "local-exec" {
command = "bq load --autodetect --source_format=CSV  btable1.table3 gs://ingsid2/cc_records.csv" 
}
 depends_on = [null_resource.download_sample_cc_into_gcs]
}
