# ci-resource-type-ami-id

Provides a Concourse-compatible resource type to retrieve AMI Image versions based on a provided `ami_prefix`, or retrieve an Image Id when provided with both an `ami_prefix` and `version`.

## Installing

Use this resource by adding the following to the `resource_types` section of a pipeline config:

```yaml
resource_types:
- name: ci-resource-type-ami-id
  type: docker-image
  source:
    aws_access_key_id: <aws_access_key_id>
    aws_secret_access_key: <aws_secret_access_key>
    repository: <docker-registry>/ci-resource-type-ami-id
    tag: latest
```

## Source Configuration

* `aws_access_key_id`: *Required.* The AWS access key to use for authentication against the AWS API
* `aws_secret_access_key`: *Required.* The AWS secret access key to use for authentication against the AWS API
* `aws_region`: *Optional* The region in which to perform lookups (Default: `"eu-west-2"`)
* `ami_owner_ids`: *Optional* A list of AWS IDs that is used to filter the AMI lookups based on the AMI Owner (Default: `["self"]`)
* `ami_prefix`: *Required.* The AMI name prefix to use when searching for AMIs
* `version_regex`: *Optional.* The regex used to extract the version from the AMI name (Default: `"(\d{1,3}\.\d{1,3}\.\d{1,3})$"`)


### Example

With the following resource configuration:

``` yaml
resources:
- name: ami-id
  type: ci-resource-type-ami-id
  source:
    aws_access_key_id: <aws_access_key_id>
    aws_secret_access_key: <aws_secret_access_key>
    ami_prefix: my-ami-name-
```

Retrieve release tags using a `get`

``` yaml
plan:
- get: ami-id
- task: a-thing-that-needs-a-version
```

## Behavior

### `check`: Report the current version number.

Detects new versions by querying AWS for all AMIs that match the supplied `ami_prefix` name pattern and extracting the version from the name

### `in`: Provide the AMI Image Id to a file

Provides the AMI Image Id to the build as an `ami-id` file in the destination.

### `out`: (Disabled)

This feature has been disabled as a precaution because it doesn't support our use case. An error will be returned with a message `This is intended for readonly use only` if invoked.

