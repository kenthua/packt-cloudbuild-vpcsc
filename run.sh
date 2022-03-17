gcloud services enable cloudbuild.googleapis.com servicenetworking.googleapis.com

gcloud compute addresses create packt-cloudbuild-private-address-range \
    --global \
    --purpose=VPC_PEERING \
    --addresses=192.168.0.0 \
    --prefix-length=16 \
    --description=cloudbuild-private-pool \
    --network=packt-cloudbuild-sandbox-vpc \
    --project kenthua-test-identity

gcloud services vpc-peerings connect \
    --service=servicenetworking.googleapis.com \
    --ranges=packt-cloudbuild-private-address-range \
    --network=packt-cloudbuild-sandbox-vpc \
    --project=kenthua-test-identity

# if the above fails
gcloud services vpc-peerings update \
    --service=servicenetworking.googleapis.com \
    --ranges=packt-cloudbuild-private-address-range \
    --network=packt-cloudbuild-sandbox-vpc \
    --project=kenthua-test-identity \
    --force

gcloud builds worker-pools create packt-private-pool \
    --config-from-file private-pool.yaml \
    --region us-west1