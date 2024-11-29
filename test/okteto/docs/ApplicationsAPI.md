# \ApplicationsAPI

All URIs are relative to *https://okteto.test.com/api/v0*

Method | HTTP request | Description
------------- | ------------- | -------------
[**ListApplicationsForNamespace**](ApplicationsAPI.md#ListApplicationsForNamespace) | **Get** /namespaces/{namespaceName}/applications | Get list of applications deployed within a namespace



## ListApplicationsForNamespace

> []Application ListApplicationsForNamespace(ctx, namespaceName).Execute()

Get list of applications deployed within a namespace



### Example

```go
package main

import (
	"context"
	"fmt"
	"os"
	openapiclient "github.com/ifbyol/okteto-public-api-samples"
)

func main() {
	namespaceName := "namespaceName_example" // string | Namespace name where the applications are deployed.

	configuration := openapiclient.NewConfiguration()
	apiClient := openapiclient.NewAPIClient(configuration)
	resp, r, err := apiClient.ApplicationsAPI.ListApplicationsForNamespace(context.Background(), namespaceName).Execute()
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error when calling `ApplicationsAPI.ListApplicationsForNamespace``: %v\n", err)
		fmt.Fprintf(os.Stderr, "Full HTTP response: %v\n", r)
	}
	// response from `ListApplicationsForNamespace`: []Application
	fmt.Fprintf(os.Stdout, "Response from `ApplicationsAPI.ListApplicationsForNamespace`: %v\n", resp)
}
```

### Path Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
**ctx** | **context.Context** | context for authentication, logging, cancellation, deadlines, tracing, etc.
**namespaceName** | **string** | Namespace name where the applications are deployed. | 

### Other Parameters

Other parameters are passed through a pointer to a apiListApplicationsForNamespaceRequest struct via the builder pattern


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------


### Return type

[**[]Application**](Application.md)

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints)
[[Back to Model list]](../README.md#documentation-for-models)
[[Back to README]](../README.md)

