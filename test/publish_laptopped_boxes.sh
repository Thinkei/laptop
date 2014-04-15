#!/usr/bin/env sh
source ./test/common

upload_box_to_temp_location(){
  message "Uploading box to s3: $BOX_NAME"
  aws s3 cp "$BOX_NAME" "s3://laptop-boxes/$BOX_NAME.tmp" --acl public-read
***REMOVED***

move_box_into_place(){
  message "Removing existing box: $BOX_NAME"
  aws s3 rm "s3://laptop-boxes/$BOX_NAME" \
    || failure_message "Could not remove $BOX_NAME"

  message "Moving new box to correct location: $BOX_NAME"
  aws s3 mv "s3://laptop-boxes/$BOX_NAME.tmp" "s3://laptop-boxes/$BOX_NAME" \
    --acl public-read || failure_message 'Could not move new box into place on s3'
***REMOVED***

remove_test_success_tracker(){
  rm "./test/succeeded.$LAPTOP_BASENAME"
***REMOVED***

publish_box(){
  set_box_names

  upload_box_to_temp_location && \
    move_box_into_place && \
    remove_test_success_tracker
***REMOVED***

check_for_aws

for vagrant***REMOVED***le in test/succeeded.*; do
  if [ -e "$vagrant***REMOVED***le" ]; then
    publish_box
***REMOVED***
done
