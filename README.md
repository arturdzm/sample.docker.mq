# Running the WebSphere Liberty and IBM MQ in an OpenShift Cluster

This files in this project illustrate how IBM MQ Operator can be used to create a
Queue Manager to communicate between two applications running on WebSphere Liberty.

The two applications can be built using the `make build-all` and pushed to a Docker
Registry defined by `REPO_NAME` env variable to using `make push-all`.

## Prerequisites

This sample is tested on Red Hat OpenShift `v4.4` on IBM Cloud with the following Operator installed:

- IBM MQ `v1.2.0`

**Note:** The sample assumes the Queue Manager and all applications are to be deployed into `ibm-mq` namespace/project.

## Steps

1. Clone repo locally and go into the `sample.docker.mq/deploy` directory:

   ```console
   $ git clone https://github.com/navidsh/sample.docker.mq/

   $ cd sample.docker.mq/deploy
   ```

2. Deploy a Queue Manager:

   ```console
   $ oc apply -k mq/
   ```

   This is going to take a few minutes until the Queue Manager becomes ready.

3. Annotate the Queue Manager service to request OpenShift to create a service TLS secret:

   ```console
   $ oc annotate service quickstart-cp4i-ibm-mq service.beta.openshift.io/serving-cert-secret-name=mq-tls
   ```

4. Deploy applications and setup mutual TLS for the queue manager:

   ```console
   $ oc apply -k apps/
   ```

   This is going to take a few minutes until the apps are ready to accept traffic.

5. Extract the host for the application route and `cURL` the endpoint:

   ```console
    $ ROUTE_HOST=$(oc get route sender-tls-ccdt -o jsonpath="{ .spec.host }")

    $ curl https://$ROUTE_HOST/sender
    <h1>Liberty - MQ - Liberty</h1>

    Results:<br>
    Creating connection to QueueManager<br>
    Sending message request of 'Give me something back receiver'<br>
    Sent Message ID=ID:414d5120515549434b5354415254202050ea755f02c1b824<br>
    Waiting for response<br>
    No response message received in 15 seconds<br>
    Closing Connection<br>
   ```

## Clean up

Run the following commands to clean up the applications and the queue manager:

```console
$ oc delete -k mq/

$ oc delete -k apps/
```
